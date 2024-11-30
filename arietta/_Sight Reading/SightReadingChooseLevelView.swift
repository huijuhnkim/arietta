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
    var buttonLevelFour: UIButton!
    var buttonLevelFive: UIButton!
    var buttonStart: UIButton!
    
    private var activeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
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
        buttonLevelFour = UtilityFunctions.getLevelButton("4")
        buttonLevelFive = UtilityFunctions.getLevelButton("5")
        
        // Add the button to the view
        self.addSubview(buttonLevelOne)
        self.addSubview(buttonLevelTwo)
        self.addSubview(buttonLevelThree)
        self.addSubview(buttonLevelFour)
        self.addSubview(buttonLevelFive)
        
        // Add action for the button tap
        buttonLevelOne.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        buttonLevelTwo.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        buttonLevelThree.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        buttonLevelFour.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
        buttonLevelFive.addTarget(self, action: #selector(levelButtonTapped(_:)), for: .touchUpInside)
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
            labelChooseLevel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            buttonLevelOne.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelOne.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45),
            buttonLevelOne.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelOne.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLevelTwo.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelTwo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 108),
            buttonLevelTwo.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelTwo.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLevelThree.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelThree.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 171),
            buttonLevelThree.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelThree.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLevelFour.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelFour.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 234),
            buttonLevelFour.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelFour.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLevelFive.topAnchor.constraint(equalTo: labelChooseLevel.bottomAnchor, constant: 17),
            buttonLevelFive.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 297),
            buttonLevelFive.widthAnchor.constraint(equalToConstant: 50),
            buttonLevelFive.heightAnchor.constraint(equalToConstant: 50),
            
            buttonStart.heightAnchor.constraint(equalToConstant: 50),
            buttonStart.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            buttonStart.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            buttonStart.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -39),
        ])
    }
}

