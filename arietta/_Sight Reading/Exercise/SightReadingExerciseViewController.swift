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
    var level = 1
    
    var scores: Scores?
    var notes = ["C", "D", "E", "F"]
    
    var arrowLayer: CAShapeLayer!
    var noteXPositions: [CGFloat] = [325, 169, 236, 303] // adjust according to image 103 169 236 303 165 218 272
    let fixedYPosition: CGFloat = 373
    
    var currentNoteIndex = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // loadRandomImageForLevel()
    }
    
    override func loadView() {
        view = SRExerciseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevelsData()
        // loadRandomImageForLevel()
        
        configureNoteRecognizer()
        addArrow()
        SRExerciseView.buttonRecord.addTarget(self, action: #selector(toggleRecording), for: .touchUpInside)
    }
    
    func loadLevelsData() {
            guard let path = Bundle.main.path(forResource: "notes", ofType: "json"),
                  let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                print("Failed to load levels data")
                return
            }

            do {
                scores = try JSONDecoder().decode(Scores.self, from: jsonData)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        func loadRandomImageForLevel() {
            guard let scores = scores else {
                print("Levels data not loaded")
                return
            }

            let score: [ScoreData]
            switch level {
            case 1:
                score = scores.level1
            case 2:
                score = scores.level2
            case 3:
                score = scores.level3
            default:
                print("Invalid level")
                return
            }

            guard !score.isEmpty else {
                print("No data available for this level")
                return
            }

            let randomIndex = Int.random(in: 0..<score.count)
            let selectedLevelData = score[randomIndex]
            notes = selectedLevelData.notes
            print(selectedLevelData)
            DispatchQueue.main.async {
                self.SRExerciseView.imageScore.image = UIImage(named: selectedLevelData.score)
            }
        }
    
    private func configureNoteRecognizer() {
            noteRecognizer = NoteRecognizer()
            noteRecognizer.pitchTapUpdateHandler = { [weak self] note in
                DispatchQueue.main.async {
                    self?.SRExerciseView.pitchLabel.text = "Detected Note: \(note)"
                    print(note)
                    self?.updateNote(note)
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
        arrowLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.9).cgColor
        arrowLayer.lineWidth = 1
        arrowLayer.fillColor = UIColor.black.cgColor
        
        arrowLayer.position = CGPoint(x: noteXPositions[0], y: fixedYPosition)

        view.layer.addSublayer(arrowLayer)
    }
    
    private func updateNote(_ note: String){
        if note == notes[currentNoteIndex]{
            updateArrowPosition()
        }
    }
    
    private func updateArrowPosition() {
        currentNoteIndex += 1
        if currentNoteIndex == 4{
            //jump to score
        }else{
            currentNoteIndex = currentNoteIndex % 4
            let xPosition = noteXPositions[currentNoteIndex]
            UIView.animate(withDuration: 0.5) {
                self.arrowLayer.position = CGPoint(x: xPosition, y: self.fixedYPosition)
            }
        }
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

