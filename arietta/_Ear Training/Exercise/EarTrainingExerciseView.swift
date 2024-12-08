//
//  EarTrainingExerciseView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/5/24.
//

import UIKit

class EarTrainingExerciseView: UIView {
    
    var labelProgress: UILabel!
    var buttonReferenceNote: UIButton!
    var buttonPressToListen: UIButton!
    
    // keyboard buttons
    var buttonKeyboardC: UIButton!
    var buttonKeyboardDb: UIButton!
    var buttonKeyboardD: UIButton!
    var buttonKeyboardEb: UIButton!
    var buttonKeyboardE: UIButton!
    var buttonKeyboardF: UIButton!
    var buttonKeyboardGb: UIButton!
    var buttonKeyboardG: UIButton!
    var buttonKeyboardAb: UIButton!
    var buttonKeyboardA: UIButton!
    var buttonKeyboardBb: UIButton!
    var buttonKeyboardB: UIButton!
    
    var buttonSubmit: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "AriettaBackgroundColor")
        
        setupLabelProgress()
        setupAudioButtons()
        setupKeyboard()
        setupButtonSubmit()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelProgress(){
        labelProgress = UILabel()
        labelProgress.textAlignment = .center
        labelProgress.font = UIFont.boldSystemFont(ofSize: 27)
        labelProgress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelProgress)
    }
    
    func setupAudioButtons() {
        buttonReferenceNote = UtilityFunctions.getStrokedButton(title: "Reference Note (C)")
        buttonReferenceNote.isSelected = false
        addSubview(buttonReferenceNote)

    
        buttonPressToListen = UtilityFunctions.getFilledButton(title: "Press to Listen")
        buttonPressToListen.isSelected = false
        addSubview(buttonPressToListen)
    }
    
    func setupKeyboard() {
        buttonKeyboardC = UtilityFunctions.getWhiteKeyboardButton(note: "C")
        addSubview(buttonKeyboardC)
        buttonKeyboardDb = UtilityFunctions.getBlackKeyboardButton(note: "Db")
        addSubview(buttonKeyboardDb)
        buttonKeyboardD = UtilityFunctions.getWhiteKeyboardButton(note: "D")
        addSubview(buttonKeyboardD)
        buttonKeyboardEb = UtilityFunctions.getBlackKeyboardButton(note: "Eb")
        addSubview(buttonKeyboardEb)
        buttonKeyboardE = UtilityFunctions.getWhiteKeyboardButton(note: "E")
        addSubview(buttonKeyboardE)
        buttonKeyboardF = UtilityFunctions.getWhiteKeyboardButton(note: "F")
        addSubview(buttonKeyboardF)
        buttonKeyboardGb = UtilityFunctions.getBlackKeyboardButton(note: "Gb")
        addSubview(buttonKeyboardGb)
        buttonKeyboardG = UtilityFunctions.getWhiteKeyboardButton(note: "G")
        addSubview(buttonKeyboardG)
        buttonKeyboardAb = UtilityFunctions.getBlackKeyboardButton(note: "Ab")
        addSubview(buttonKeyboardAb)
        buttonKeyboardA = UtilityFunctions.getWhiteKeyboardButton(note: "A")
        addSubview(buttonKeyboardA)
        buttonKeyboardBb = UtilityFunctions.getBlackKeyboardButton(note: "Bb")
        addSubview(buttonKeyboardBb)
        buttonKeyboardB = UtilityFunctions.getWhiteKeyboardButton(note: "B")
        addSubview(buttonKeyboardB)
        
        buttonKeyboardC.addTarget(self, action: #selector(onButtonWhiteKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardDb.addTarget(self, action: #selector(onButtonBlackKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardD.addTarget(self, action: #selector(onButtonWhiteKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardEb.addTarget(self, action: #selector(onButtonBlackKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardE.addTarget(self, action: #selector(onButtonWhiteKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardF.addTarget(self, action: #selector(onButtonWhiteKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardGb.addTarget(self, action: #selector(onButtonBlackKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardG.addTarget(self, action: #selector(onButtonWhiteKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardAb.addTarget(self, action: #selector(onButtonBlackKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardA.addTarget(self, action: #selector(onButtonWhiteKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardBb.addTarget(self, action: #selector(onButtonBlackKeyboardTapped(_:)), for: .touchUpInside)
        buttonKeyboardB.addTarget(self, action: #selector(onButtonWhiteKeyboardTapped(_:)), for: .touchUpInside)
    }
    
    @objc func onButtonWhiteKeyboardTapped(_ sender: UIButton) {
        
        if !sender.isSelected {
            sender.layer.borderWidth = 5
            sender.isSelected = true
        } else {
            sender.layer.borderWidth = 2
            sender.isSelected = false
        }
    }
    
    @objc func onButtonBlackKeyboardTapped(_ sender: UIButton) {
        if !sender.isSelected {
            sender.layer.borderWidth = 5
            sender.backgroundColor = UIColor(named: "AriettaBackgroundColor")
            sender.setAttributedTitle(UtilityFunctions.attributedBlackBodyText(text: sender.titleLabel!.text!, fontSize: 18), for: .normal)
            sender.isSelected = true

        } else {
            sender.layer.borderWidth = 2
            sender.backgroundColor = UIColor(named: "AriettaButtonColor")
            sender.setTitleColor(UIColor(named: "AriettaBackgroundColor"), for: .normal)
            sender.setAttributedTitle(UtilityFunctions.attributedWhiteBodyText(text: sender.titleLabel!.text!, fontSize: 18), for: .normal)
            sender.isSelected = false
        }
    }
    
    func setupButtonSubmit() {
        buttonSubmit = UtilityFunctions.getFilledButton(title: "Submit")
        addSubview(buttonSubmit)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelProgress.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelProgress.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            
            buttonReferenceNote.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonReferenceNote.topAnchor.constraint(equalTo: self.topAnchor, constant: 280),
            
            buttonPressToListen.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonPressToListen.topAnchor.constraint(equalTo: buttonReferenceNote.bottomAnchor, constant: 24),
            
            buttonSubmit.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSubmit.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            
            buttonKeyboardC.topAnchor.constraint(equalTo: self.topAnchor, constant: 630),
            buttonKeyboardC.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            buttonKeyboardD.centerYAnchor.constraint(equalTo: buttonKeyboardC.centerYAnchor),
            buttonKeyboardD.leadingAnchor.constraint(equalTo: buttonKeyboardC.trailingAnchor, constant: 6),
            buttonKeyboardE.centerYAnchor.constraint(equalTo: buttonKeyboardC.centerYAnchor),
            buttonKeyboardE.leadingAnchor.constraint(equalTo: buttonKeyboardD.trailingAnchor, constant: 6),
            buttonKeyboardF.centerYAnchor.constraint(equalTo: buttonKeyboardC.centerYAnchor),
            buttonKeyboardF.leadingAnchor.constraint(equalTo: buttonKeyboardE.trailingAnchor, constant: 6),
            buttonKeyboardG.centerYAnchor.constraint(equalTo: buttonKeyboardC.centerYAnchor),
            buttonKeyboardG.leadingAnchor.constraint(equalTo: buttonKeyboardF.trailingAnchor, constant: 6),
            buttonKeyboardA.centerYAnchor.constraint(equalTo: buttonKeyboardC.centerYAnchor),
            buttonKeyboardA.leadingAnchor.constraint(equalTo: buttonKeyboardG.trailingAnchor, constant: 6),
            buttonKeyboardB.centerYAnchor.constraint(equalTo: buttonKeyboardC.centerYAnchor),
            buttonKeyboardB.leadingAnchor.constraint(equalTo: buttonKeyboardA.trailingAnchor, constant: 6),
            
            buttonKeyboardDb.topAnchor.constraint(equalTo: self.topAnchor, constant:510),
            buttonKeyboardDb.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 41),
            buttonKeyboardEb.centerYAnchor.constraint(equalTo: buttonKeyboardDb.centerYAnchor),
            buttonKeyboardEb.leadingAnchor.constraint(equalTo: buttonKeyboardDb.trailingAnchor, constant: 6),
            buttonKeyboardGb.centerYAnchor.constraint(equalTo: buttonKeyboardDb.centerYAnchor),
            buttonKeyboardGb.leadingAnchor.constraint(equalTo: buttonKeyboardEb.trailingAnchor, constant: 54),
            buttonKeyboardAb.centerYAnchor.constraint(equalTo: buttonKeyboardDb.centerYAnchor),
            buttonKeyboardAb.leadingAnchor.constraint(equalTo: buttonKeyboardGb.trailingAnchor, constant: 6),
            buttonKeyboardBb.centerYAnchor.constraint(equalTo: buttonKeyboardDb.centerYAnchor),
            buttonKeyboardBb.leadingAnchor.constraint(equalTo: buttonKeyboardAb.trailingAnchor, constant: 6),
        ])
    }

}
