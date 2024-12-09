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
    
    private var lastNote: String = ""
    private var lastNoteCount: Int = 0
    private let noteStabilizationThreshold: Int = 3
    
    let noteFrequencies: [Float] = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNames = ["C", "C♯/D♭", "D", "D♯/E♭", "E", "F", "F♯/G♭", "G", "G♯/A♭", "A", "A♯/B♭", "B"]

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
            if note == self.lastNote {
                self.lastNoteCount += 1
            } else {
                self.lastNote = note
                self.lastNoteCount = 1
            }
            if self.lastNoteCount >= self.noteStabilizationThreshold {
                self.pitchTapUpdateHandler?(note)
                self.lastNoteCount = 0
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
        var frequency = frequency
        while frequency > Float(noteFrequencies.last!) {
            frequency /= 2.0
        }
        while frequency < Float(noteFrequencies.first!) {
            frequency *= 2.0
        }

        var minDistance: Float = Float.infinity
        var index = 0
        for (i, noteFrequency) in noteFrequencies.enumerated() {
            let distance = fabsf(frequency - noteFrequency)
            if distance < minDistance {
                minDistance = distance
                index = i
            }
        }
        let octave = Int(log2f(frequency / noteFrequencies[index]) * 12.0) / 12 + 4
        // print("\(noteNamesWithSharps[index])\(octave)")
        return "\(noteNames[index])\(octave)"
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
