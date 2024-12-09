//
//  SightReadingExerciseViewController.swift
//  arietta
//
//  Created by Charles Yang on 12/6/24.
//

import UIKit
import AudioKit
import AVFoundation
import FirebaseAuth
import FirebaseFirestore

class SightReadingExerciseViewController: UIViewController {

    let SRExerciseView = SightReadingExerciseView()
    
    var isRecording = false
    var noteRecognizer: NoteRecognizer!
    var level = 1
    var result = 4
    
    var audioPlayer: AVAudioPlayer?
    var scores: Scores?
    var notes = ["C", "D", "E", "F"]
    
    var arrowLayer: CAShapeLayer!
    var noteXPositions: [CGFloat] = [165, 218, 272, 325] // adjust according to image 103 169 236 303 || 165 218 272 325
    let fixedYPosition: CGFloat = 373
    
    var currentNoteIndex = 0
    
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRandomImageForLevel()
        currentUser = Auth.auth().currentUser
    }
    
    override func loadView() {
        view = SRExerciseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevelsData()
        loadRandomImageForLevel()
        
        configureNoteRecognizer()
        addArrow()
        SRExerciseView.buttonRecord.addTarget(self, action: #selector(toggleRecording), for: .touchUpInside)
        SRExerciseView.buttonReferenceNote.addTarget(self, action: #selector(playReferenceNote), for: .touchUpInside)
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
                    self?.SRExerciseView.pitchLabel.text = "\(note)"
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
        if currentNoteIndex >= 4 {
            return
        }
        var noteName = note.dropLast()
        if noteName != notes[currentNoteIndex]{
            self.result -= 1
            DispatchQueue.main.async {
                self.SRExerciseView.pitchLabel.textColor = UIColor.red
                self.triggerFeedback()
            }
        }
        currentNoteIndex += 1
        updateArrowPosition()
    }
    
    private func triggerFeedback() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.error)
    }
    
    private func updateArrowPosition() {
        if currentNoteIndex == 4{
            currentNoteIndex += 1
            noteRecognizer.stop()
            print(currentNoteIndex)
            saveResult(difficulty: level, score: result)
            let resultVC = SightReadingResultsViewController()
            resultVC.result = result
            navigationController?.pushViewController(resultVC, animated: true)
        }else if currentNoteIndex < 4{
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
    
    // play reference note C
    @objc func playReferenceNote(){
        SRExerciseView.buttonReferenceNote.isSelected.toggle()
        
        if SRExerciseView.buttonReferenceNote.isSelected {
            SRExerciseView.buttonReferenceNote.backgroundColor = UIColor(named: "AriettaGreen")
            playNoteAudio(note: "referenceNote")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.SRExerciseView.buttonReferenceNote.backgroundColor = UIColor(named:"AriettaBackgroundColor")
                self.SRExerciseView.buttonReferenceNote.isSelected = false
            }
        } else {
            SRExerciseView.buttonReferenceNote.backgroundColor = UIColor(named:"AriettaBackgroundColor")
        }
    }
    
    // play audio file with given note
    func playNoteAudio(note: String){
        guard let filePath = Bundle.main.path(forResource: note, ofType: "aif") else {
            print("Audio file not found.")
            return
        }
    
        let url = URL(fileURLWithPath: filePath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        catch {
            print("Error. Cannot play audio file.")
        }
    }
    
    func saveResult(difficulty: Int, score: Int) {
        guard let userId = currentUser?.uid else {
            print("Error: Current user is nil. Cannot fetch Firestore data.")
            return
        }
        let result = Result(date: Date(), difficulty: difficulty, score: score)
            
        let collectionMessages =
        self.database.collection("users")
            .document(currentUser?.uid ?? "")
            .collection("sightReadingResults")
            
        do{
            try collectionMessages.addDocument(from: result, completion: {(error) in
                if error == nil{
                    print("Result saved successfully.")
                }
                else{
                    print("Error adding document:")
                }
            })
        }
        catch {
            print("Error adding result.")
        }
    }

}

