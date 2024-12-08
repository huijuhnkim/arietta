//
//  SightReadingExerciseViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/5/24.
//

import UIKit
import AudioKit

class SightReadingExerciseViewController: UIViewController {

    let SRExerciseView = SightReadingExerciseView()
    
    var isRecording = false
    
    var noteRecognizer: NoteRecognizer!
    
    override func loadView() {
        view = SRExerciseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNoteRecognizer()

        // Do any additional setup after loading the view.
        SRExerciseView.buttonRecord.addTarget(self, action: #selector(toggleRecording), for: .touchUpInside)
    }
    
    private func configureNoteRecognizer() {
            noteRecognizer = NoteRecognizer()
            noteRecognizer.pitchTapUpdateHandler = { [weak self] note in
                DispatchQueue.main.async {
                    self?.SRExerciseView.pitchLabel.text = "Detected Note: \(note)"
                }
            }
        }
    
    
    @objc func toggleRecording(_ sender: UIButton) {
        if isRecording {
            noteRecognizer.stop()
            SRExerciseView.buttonRecord.setTitle("Start Recording", for: .normal)
            SRExerciseView.buttonRecord.backgroundColor = UIColor(named: "AriettaButtonColor")
            print("end")
            isRecording = false
        } else {
            noteRecognizer.start()
            SRExerciseView.buttonRecord.setTitle("Stop Recording", for: .normal)
            SRExerciseView.buttonRecord.backgroundColor = UIColor(named: "AriettaRed")
            print("start")
            isRecording = true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
