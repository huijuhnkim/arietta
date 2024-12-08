//
//  SightReadingResultsView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/8/24.
//

import UIKit

class SightReadingResultsView: UIView {

    var labelTotal: UILabel!
    var labelResult: UILabel!
    var buttonRetry: UIButton!
    var buttonMainMenu: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named:"AriettaBackgroundColor")
        
        setup()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        labelTotal = UILabel()
        labelTotal.translatesAutoresizingMaskIntoConstraints = false
        labelTotal.attributedText = UtilityFunctions.attributedBlackBodyText(text: "/ 4", fontSize: 48)
        addSubview(labelTotal)
        
        labelResult = UILabel()
        labelResult.translatesAutoresizingMaskIntoConstraints = false
        labelResult.attributedText = UtilityFunctions.attributedBlackBodyText(text: "4", fontSize: 120)
        addSubview(labelResult)
        
        buttonRetry = UtilityFunctions.getFilledButton(title: "Retry")
        addSubview(buttonRetry)
        
        buttonMainMenu = UtilityFunctions.getFilledButton(title: "Main Menu")
        addSubview(buttonMainMenu)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            labelTotal.topAnchor.constraint(equalTo: self.topAnchor, constant: 427),
            labelTotal.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 193),
            
            labelResult.topAnchor.constraint(equalTo: self.topAnchor, constant: 330),
            labelResult.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 140),
            
            buttonMainMenu.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonMainMenu.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            
            buttonRetry.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonRetry.bottomAnchor.constraint(equalTo: buttonMainMenu.topAnchor, constant: -24),
        ])
    }
}
