//
//  SightReadingExerciseViewController.swift
//  arietta
//
//  Created by Charles Yang on 12/6/24.
//

import UIKit
import AudioKit

class SightReadingExerciseViewController: UIViewController {

    let SRExerciseView = SightReadingExerciseView()
    
    var isRecording = false
    var noteRecognizer: NoteRecognizer!
    
    var arrowLayer: CAShapeLayer!
    var noteXPositions: [CGFloat] = [102, 169, 236, 303] // adjust according to image 103 169 236 303
    let fixedYPosition: CGFloat = 373
    
    var currentNoteIndex = 0
    
    override func loadView() {
        view = SRExerciseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNoteRecognizer()
        addArrow()
        SRExerciseView.buttonRecord.addTarget(self, action: #selector(toggleRecording), for: .touchUpInside)
    }
    
    private func configureNoteRecognizer() {
            noteRecognizer = NoteRecognizer()
            noteRecognizer.pitchTapUpdateHandler = { [weak self] note in
                DispatchQueue.main.async {
                    self?.SRExerciseView.pitchLabel.text = "Detected Note: \(note)"
                    // 更新箭头的位置
                    self?.updateArrowPosition()
                }
            }
        }
    

    private func addArrow() {
        let combinedPath = UIBezierPath()
        
        // create arrow shape
        combinedPath.move(to: CGPoint(x: -7.5, y: 0))
        combinedPath.addLine(to: CGPoint(x: 7.5, y: 0))
        combinedPath.addLine(to: CGPoint(x: 0, y: 15))
        combinedPath.close()

        // creating line
        combinedPath.move(to: CGPoint(x: 0, y: 15))
        combinedPath.addLine(to: CGPoint(x: 0, y: 135))

        arrowLayer = CAShapeLayer()
        arrowLayer.path = combinedPath.cgPath
        arrowLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.9).cgColor  // 设置线的颜色为更浅且半透明
        arrowLayer.lineWidth = 1
        arrowLayer.fillColor = UIColor.black.cgColor
        
        arrowLayer.position = CGPoint(x: noteXPositions[0], y: fixedYPosition)

        view.layer.addSublayer(arrowLayer)
    }
    
    private func updateArrowPosition() {
        currentNoteIndex = currentNoteIndex % 4
        let xPosition = noteXPositions[currentNoteIndex]
        UIView.animate(withDuration: 0.5) {
            self.arrowLayer.position = CGPoint(x: xPosition, y: self.fixedYPosition)
        }
        currentNoteIndex += 1
    }
    
    
    @objc func toggleRecording(_ sender: UIButton) {
        if isRecording {
            noteRecognizer.stop()
            SRExerciseView.buttonRecord.setTitle("Start Recording", for: .normal)
            print("start")
            SRExerciseView.buttonRecord.backgroundColor = UIColor(named: "AriettaButtonColor")
            print("end")
            isRecording = false
        } else {
            noteRecognizer.start()
            SRExerciseView.buttonRecord.setTitle("Stop Recording", for: .normal)
            print("stop")
            SRExerciseView.buttonRecord.backgroundColor = UIColor(named: "AriettaRed")
            print("start")
            isRecording = true
        }
    }

}

