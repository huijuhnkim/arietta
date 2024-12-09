
//
//  EarTrainingExerciseViewController.swift
//  arietta
//
//  Created by Christina Kang on 12/4/24.
//

import UIKit
import AVFoundation
import FirebaseAuth
import FirebaseFirestore

class EarTrainingExerciseViewController: UIViewController {
        
    required init(selectedDifficulty: Int) {
            self.selectedDifficulty = selectedDifficulty
            super.init(nibName: nil, bundle: nil)
        }
            
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    let ETExercise = EarTrainingExerciseView()
    var audioPlayer: AVAudioPlayer?
    
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
        
    var selectedDifficulty: Int
    var score: Int = 0
    var currentQuestion = 1
    var correctNote: [String?] = []
    var referenceNote = "C"
    var selectedNotes: [String?] = []
        
    override func loadView() {
        view = ETExercise
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
            
        // setup play reference and press to listen note
        ETExercise.buttonReferenceNote.addTarget(self, action: #selector(playReferenceNote), for: .touchUpInside)
        ETExercise.buttonPressToListen.addTarget(self, action: #selector(playPressToListenNote), for: .touchUpInside)
            
        let keyboardButtons = [
            ETExercise.buttonKeyboardC, ETExercise.buttonKeyboardDb,
            ETExercise.buttonKeyboardD, ETExercise.buttonKeyboardEb,
            ETExercise.buttonKeyboardE, ETExercise.buttonKeyboardF,
            ETExercise.buttonKeyboardGb, ETExercise.buttonKeyboardG,
            ETExercise.buttonKeyboardAb, ETExercise.buttonKeyboardA,
            ETExercise.buttonKeyboardBb, ETExercise.buttonKeyboardB
            ]
            
        for button in keyboardButtons {
            button?.addTarget(self, action: #selector(onKeyboardButtonTapped(_:)), for: .touchUpInside)
            }
            
        startNextQuestion()
        ETExercise.buttonSubmit.addTarget(self, action: #selector(onButtonSubmitTapped), for: .touchUpInside)
            
        }
        
    @objc func onKeyboardButtonTapped(_ sender: UIButton){
    
    // update selected notes if multiple notes are selected
        if let note = sender.titleLabel?.text {
            if sender.isSelected {
                // add to list of selected notes
                selectedNotes.append(note)
            } else { // unselecting a note
                selectedNotes.removeAll { $0 == note }
                }
            }
        }
        
    @objc func onButtonSubmitTapped(){
        let keyboardButtons = [
            ETExercise.buttonKeyboardC, ETExercise.buttonKeyboardDb,
            ETExercise.buttonKeyboardD, ETExercise.buttonKeyboardEb,
            ETExercise.buttonKeyboardE, ETExercise.buttonKeyboardF,
            ETExercise.buttonKeyboardGb, ETExercise.buttonKeyboardG,
            ETExercise.buttonKeyboardAb, ETExercise.buttonKeyboardA,
            ETExercise.buttonKeyboardBb, ETExercise.buttonKeyboardB
            ]
    
        // checks if there are no keyboard notes selected
        guard !selectedNotes.isEmpty else {
            noSelectedNotesAlert()
            return
        }
            
        guard let correctNotes = correctNote as? [String] else { return }
        let checkCorrectAnswer = selectedNotes.contains { correctNotes.contains($0 ?? "")}
         
        // check if the selected buttons are correct/incorrect
        for button in keyboardButtons {
            if let buttonNote = button?.titleLabel?.text {
                if selectedNotes.contains(buttonNote) {
                    // only the user's selected buttons are highlighted green or red
                    if correctNotes.contains(buttonNote) {
                        button?.backgroundColor = UIColor(named: "AriettaGreen")
                    } else { // reset background color for unselected buttons
                        button?.backgroundColor = UIColor(named: "AriettaRed")
                    }
                }
            }
        }
        
        // if the user is correct, increment score
        if checkCorrectAnswer {
            score += 1
            nextQuestion()
        } else {
            nextQuestion()
        }
        
        // add a 0.5 sec delay to show the user their guess is correct/incorrect and then move on to next question
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // remove so that previously guessed answers are not shown
            self.selectedNotes.removeAll()
            self.resetKeyboardButtons()
        }
    }
     
    // will keep going until user answered 10 questions
    func nextQuestion(){
        if currentQuestion < 5 {
            currentQuestion += 1
            startNextQuestion()
            } else {
                saveResult(difficulty: selectedDifficulty, score: score)
                let resultsVC = EarTrainingResultsViewController(score: score, selectedDifficulty: selectedDifficulty)
                navigationController?.pushViewController(resultsVC, animated: true)
                }
            }
    // generate a note for the next question
    func startNextQuestion(){
        let generatedNotes = getCorrectNote(difficulty: selectedDifficulty)
        correctNote = generatedNotes ?? []
                
        // update progress level
        ETExercise.labelProgress.text = "\(currentQuestion)/5"
        }
    
    // reset keyboard buttons after every question
    func resetKeyboardButtons(){
        let keyboardWhiteButtons = [
            ETExercise.buttonKeyboardC,ETExercise.buttonKeyboardD,
            ETExercise.buttonKeyboardE, ETExercise.buttonKeyboardF,
            ETExercise.buttonKeyboardG,ETExercise.buttonKeyboardA,
            ETExercise.buttonKeyboardB
        ]
                
        let keyboardBlackButtons = [
            ETExercise.buttonKeyboardDb,ETExercise.buttonKeyboardEb,
            ETExercise.buttonKeyboardGb,ETExercise.buttonKeyboardAb,
            ETExercise.buttonKeyboardBb
        ]
                
        for button in keyboardWhiteButtons {
            button?.layer.borderWidth = 2
            button?.isSelected = false
                button?.backgroundColor = UIColor(named: "AriettaBackgroundColor")
            }
                
        for button in keyboardBlackButtons {
                button?.layer.borderWidth = 2
                button?.isSelected = false
                button?.setAttributedTitle(UtilityFunctions.attributedWhiteBodyText(text: button?.titleLabel!.text! ?? "", fontSize: 18), for: .normal)
                button?.backgroundColor = UIColor(named: "AriettaButtonColor")
                button?.setTitleColor(UIColor(named: "AriettaBackgroundColor"), for: .normal)
                }
            }
        
    // randomly choose a note depending on difficulty level
    func getCorrectNote(difficulty: Int) -> [String]?{
            let storedAudioNotes: [String]
            switch difficulty {
            case 1:
                storedAudioNotes = ["level1-A","level1-B", "level1-C", "level1-D", "level1-E", "level1-F", "level1-G"]
            case 2:
                storedAudioNotes = ["level2-A","level2-Bb", "level2-B", "level2-C", "level2-Db", "level2-D", "level2-Eb", "level2-E", "level2-F",
                                    "level2-Gb", "level2-G"]
            case 3:
                storedAudioNotes = ["level3-A-C#","level3-A-D", "level3-A-E", "level3-A-F#", "level3-A-G#", "level3-B-A#", "level3-B-D#","level3-B-E", "level3-B-F#","level3-B-G#","level3-C-A","level3-C-B","level3-C-E","level3-C-F","level3-C-G","level3-D-A","level3-D-B","level3-D-C#","level3-D-F#","level3-D-G","level3-E-A","level3-E-B","level3-E-C#","level3-E-D#","level3-E-G#","level3-F-A","level3-F-Bb","level3-F-C","level3-F-D","level3-F-E","level3-G-B","level3-G-C","level3-G-D","level3-G-E","level3-G-F#"]
            default:
                    storedAudioNotes = []
                }
                
            guard let randomlyChosenNote = storedAudioNotes.randomElement() else {
                    return nil
                }
                
            if difficulty == 3 {
                return randomlyChosenNote.split(separator: "-").dropFirst().map { String($0)}
                } else {
                    // get correct note from the audio file name
                    return [String(randomlyChosenNote.split(separator:"-").last ?? "")]
                }
            }
    
        // play audio file according to difficulty level and the randomly chosen note
    @objc func playPressToListenNote(){
        
        ETExercise.buttonPressToListen.isSelected.toggle()
        
        if ETExercise.buttonPressToListen.isSelected {
            ETExercise.buttonPressToListen.backgroundColor = UIColor(named: "AriettaRed")
            // level 3 has different formatting and has two notes instead of one
            if selectedDifficulty == 3 {
                let notePlay = correctNote.compactMap{ $0 }.joined(separator:"-")
                playNoteAudio(note: "level3-\(notePlay)")
            } else {
                if let singleNote = correctNote.first ?? nil {
                    let notePlay = "level\(selectedDifficulty)-" + singleNote
                    playNoteAudio(note: notePlay)
                }
                else {
                    print("Cannot find audio file to play.")
                }
            }
            // go back to default background color after 0.3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.ETExercise.buttonPressToListen.backgroundColor = UIColor(named: "AriettaButtonColor")
                self.ETExercise.buttonPressToListen.isSelected = false
            }
        }
        else {
            ETExercise.buttonPressToListen.backgroundColor = UIColor(named:"AriettaButtonColor")
        }
    }
        
    // play reference note C
    @objc func playReferenceNote(){
        ETExercise.buttonReferenceNote.isSelected.toggle()
        
        if ETExercise.buttonReferenceNote.isSelected {
            ETExercise.buttonReferenceNote.backgroundColor = UIColor(named: "AriettaGreen")
            playNoteAudio(note: "referenceNote")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.ETExercise.buttonReferenceNote.backgroundColor = UIColor(named:"AriettaBackgroundColor")
                self.ETExercise.buttonReferenceNote.isSelected = false
            }
        } else {
            ETExercise.buttonReferenceNote.backgroundColor = UIColor(named:"AriettaBackgroundColor")
        }
    }
    
    // play audio file with given note
        func playNoteAudio(note: String){
            guard let filePath = Bundle.main.path(forResource: note, ofType: "aif") else {
                    print("Audio file not found.")
                    return }
    
                let url = URL(fileURLWithPath: filePath)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                }
                catch {
                    print("Error. Cannot play audio file.")
                }
            }
    
    // alert when user did not select a button
    func noSelectedNotesAlert(){
            let alert = UIAlertController(title: "No Note Selected!", message: "Error! Must select a note before submitting!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    
    
    func saveResult(difficulty: Int, score: Int) {
        guard let userId = currentUser?.uid else {
               print("Error: Current user is nil. Cannot fetch Firestore data.\(currentUser)")
               return
           }
        let result = ETResult(date: Date(), difficulty: difficulty, score: score)
        
        let collectionMessages =
        self.database.collection("users")
            .document(currentUser?.uid ?? "")
            .collection("earTrainingResults")
        
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


