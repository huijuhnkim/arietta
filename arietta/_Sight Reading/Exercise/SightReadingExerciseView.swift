//
//  SightReadingExerciseView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/5/24.
//

import UIKit

class SightReadingExerciseView: UIView {

    var imageScore: UIImageView!
    var buttonReferenceNote: UIButton!
    var buttonRecord: UIButton!
    var pitchLabel: UILabel!
    
    private var buttonReferenceNoteIsActive = false
    private var buttonRecordIsActive = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "AriettaBackgroundColor")
        
        setupImageScore()
        setupButtonReferenceNote()
        setupButtonRecord()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageScore() {
        imageScore = UIImageView(image: UIImage(named: "level1_1"))
        imageScore.translatesAutoresizingMaskIntoConstraints = false
        imageScore.contentMode = .scaleAspectFit
        imageScore.clipsToBounds = true
        addSubview(imageScore)
        
        // Pitch label
                pitchLabel = UILabel()
                pitchLabel.translatesAutoresizingMaskIntoConstraints = false
                pitchLabel.numberOfLines = 0
                pitchLabel.text = "Pitch: -- Hz\nAmplitude: --"
                pitchLabel.textAlignment = .center
                pitchLabel.font = UIFont.systemFont(ofSize: 24)
                addSubview(pitchLabel)
        
    }
    
    func setupButtonReferenceNote() {
        buttonReferenceNote = UtilityFunctions.getStrokedButton(title: "Reference Note (C)")
        buttonReferenceNote.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonReferenceNote)
        
        buttonReferenceNote.addTarget(self, action: #selector(onButtonReferenceNoteTapped(_:)), for: .touchUpInside)
    }
    
    @objc func onButtonReferenceNoteTapped(_ sender: UIButton) {
        if buttonReferenceNoteIsActive {
            sender.backgroundColor = UIColor(named: "AriettaBackgroundColor")
            buttonReferenceNoteIsActive = false
        } else {
            sender.backgroundColor = UIColor(named: "AriettaGreen")
            buttonReferenceNoteIsActive = true
        }
    }
    
    func setupButtonRecord() {
        buttonRecord = UtilityFunctions.getFilledButton(title: "Record")
        buttonRecord.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonRecord)
        
        buttonRecord.addTarget(self, action: #selector(onButtonRecordTapped(_:)), for: .touchUpInside)
    }
    
    @objc func onButtonRecordTapped(_ sender: UIButton) {
        if buttonRecordIsActive {
            sender.backgroundColor = UIColor(named: "AriettaButtonColor")
            buttonRecordIsActive = false
        } else {
            sender.backgroundColor = UIColor(named: "AriettaRed")
            buttonRecordIsActive = true
        }
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            imageScore.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageScore.topAnchor.constraint(equalTo: self.topAnchor, constant: 330),
            imageScore.widthAnchor.constraint(equalToConstant: 330),
            
            pitchLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pitchLabel.topAnchor.constraint(equalTo: imageScore.bottomAnchor, constant: 30),
            
            buttonRecord.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonRecord.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            
            buttonReferenceNote.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonReferenceNote.bottomAnchor.constraint(equalTo: buttonRecord.topAnchor, constant: -24)
        ])
    }
}
