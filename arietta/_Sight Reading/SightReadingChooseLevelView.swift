//
//  EarTrainingChooseLevelView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/30/24.
//

import UIKit

class SightReadingChooseLevelView: UIView {
    
    var labelChooseLevel: UILabel!
    var buttonLevelOne: UIButton!
    var buttonLevelTwo: UIButton!
    var buttonLevelThree: UIButton!
    var buttonStart: UIButton!
    
    private var activeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named:"AriettaBackgroundColor")
        
        setupLabelChooseLevel()
        setupButtonLevel()
        setupButtonStart()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelChooseLevel() {
        labelChooseLevel = UILabel()
        
        labelChooseLevel.attributedText = UtilityFunctions.attributedBlackBodyText(
            text: "Choose Level of Difficulty:", fontSize: 18)
        labelChooseLevel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelChooseLevel)
    }
    
    func setupButtonLevel() {
        buttonLevelOne = UtilityFunctions.getLevelButton("1")
        buttonLevelTwo = UtilityFunctions.getLevelButton("2")
        buttonLevelThree = UtilityFunctions.getLevelButton("3")
        
        // Add the button to the view
        self.addSubview(buttonLevelOne)
        self.addSubview(buttonLevelTwo)
        self.addSubview(buttonLevelThree)
        
        // Add action for the button tap
        buttonLevelOne.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        buttonLevelTwo.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        buttonLevelThree.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func levelButtonTapped(_ sender: UIButton) {
        // Check the current background color and toggle
        if let previousButton = activeButton {
            previousButton.backgroundColor = UIColor(named: "AriettaButtonColor")
            previousButton.setAttributedTitle(
                UtilityFunctions.attributedWhiteBodyText(text: previousButton.titleLabel!.text!, fontSize: 18),
                for: .normal)
            previousButton.layer.borderColor = UIColor.clear.cgColor
        }
        
        // Enable the tapped button (make it "active")
        sender.backgroundColor = UIColor(named: "AriettaBackgroundColor")
        sender.setAttributedTitle(
            UtilityFunctions.attributedBlackBodyText(text: sender.titleLabel!.text!, fontSize: 18),
            for: .normal)
        sender.layer.borderColor = UIColor(named: "AriettaButtonColor")?.cgColor
        
        // Update active button
        activeButton = sender
    }
    
    func setupButtonStart() {
        buttonStart = UtilityFunctions.getButton(title: "Start")
        self.addSubview(buttonStart)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelChooseLevel.topAnchor.constraint(equalTo: self.topAnchor, constant: 337),
            labelChooseLevel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonLevelOne.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelOne.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 99),
            buttonLevelOne.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelOne.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLevelTwo.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelTwo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 171),
            buttonLevelTwo.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelTwo.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLevelThree.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelThree.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 243),
            buttonLevelThree.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelThree.heightAnchor.constraint(equalToConstant: 50),
            
            buttonStart.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStart.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -39),
        ])
    }
}

