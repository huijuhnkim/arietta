//
//  NoteRecognizer.swift
//  arietta
//
//  Created by Charles Yang on 12/6/24.
//

import AudioKit
import AVFAudio
import SoundpipeAudioKit

class NoteRecognizer {
    var engine = AudioEngine()
    var mic: AudioEngine.InputNode!
    var pitchTap: PitchTap!
    
    var pitchTapUpdateHandler: ((String) -> Void)?
    
    // 用于音符去抖动的变量
    private var lastNote: String = ""
    private var lastNoteCount: Int = 0
    private let noteStabilizationThreshold: Int = 3
    
    private var frequencySamples: [Float] = []
    private let maxSamples = 10  // 样本最大数量

    init() {
        requestMicrophoneAccess { [weak self] granted in
            guard granted else {
                print("Microphone access denied.")
                return
            }
            self?.setupAudio()
        }
    }
    
    private func setupAudio() {
        guard let input = engine.input else {
            fatalError("Unable to access microphone.")
        }
        mic = input
        setupPitchTap()
    }

    private func setupPitchTap() {
        pitchTap = PitchTap(mic) { [weak self] pitch, amp in
            guard let self = self, let pitch = pitch.first, let amp = amp.first, amp > 0.1 else { return }
            let note = self.frequencyToNote(frequency: pitch)
            // 检查当前音符是否与最后一次检测的音符相同
            if note == self.lastNote {
                self.lastNoteCount += 1
            } else {
                self.lastNote = note
                self.lastNoteCount = 1
            }
            // 只有当相同的音符连续出现达到一定次数时才更新
            if self.lastNoteCount >= self.noteStabilizationThreshold {
                self.pitchTapUpdateHandler?(note)
                self.lastNoteCount = 0  // 重置计数器
            }
        }
        engine.output = Mixer([mic])
    }

    func start() {
        do {
            pitchTap.start()
            try engine.start()
        } catch {
            print("Audio engine failed to start: \(error).")
        }
    }

    func stop() {
        pitchTap.stop()
        engine.stop()
    }

    private func frequencyToNote(frequency: Float) -> String {
        let noteNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]

        // 添加当前频率到样本列表
        frequencySamples.append(frequency)
        if frequencySamples.count > maxSamples {
            frequencySamples.removeFirst()
        }
        
        // 计算样本的平均频率
        let averageFrequency = frequencySamples.reduce(0, +) / Float(frequencySamples.count)

        if averageFrequency < 20 {  // 通常认为人耳能听到的最低频率约为20Hz
            return "Frequency too low"
        }

        let noteIndexCalc = log2(averageFrequency / 440.0) * 12.0
        var noteIndex = Int(round(noteIndexCalc)) % 12
        let octave = Int(noteIndexCalc / 12.0) + 4

        if noteIndex < 0 {
            noteIndex += 12
        }
        
        print("\(noteNames[noteIndex])\(octave)")

        return "\(noteNames[noteIndex])\(octave)"
    }
    
    private func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            session.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        } catch {
            print("Failed to set up audio session: \(error)")
            completion(false)
        }
    }
}
