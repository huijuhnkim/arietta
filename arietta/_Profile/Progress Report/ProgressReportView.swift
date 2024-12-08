//
//  ProgressReportView.swift
//  arietta
//
//  Created by Christina Kang on 12/8/24.
//

import UIKit

class ProgressReportView: UIView {
    var labelScore: UILabel!
    var buttonRetry: UIButton!
    var buttonMenu: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named:"AriettaBackgroundColor")
    
        setupLabelScore()
        setupButtonRetry()
        setupButtonMenu()
        initConstraints()
        
    }
    
    func setupLabelScore(){
        labelScore = UILabel()
        labelScore.textAlignment = .center
        labelScore.font = UIFont.boldSystemFont(ofSize: 90)
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelScore)
    }
    
    @objc func setupButtonRetry(){
        buttonRetry = UtilityFunctions.getFilledButton(title: "Retry")
        self.addSubview(buttonRetry)
        
    }
    
    @objc func setupButtonMenu(){
        buttonMenu = UtilityFunctions.getFilledButton(title: "Main Menu")
        self.addSubview(buttonMenu)
    }
    
     func initConstraints(){
         NSLayoutConstraint.activate([

            labelScore.topAnchor.constraint(equalTo: self.topAnchor, constant: 350),
            labelScore.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         
            buttonRetry.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonRetry.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
             
            buttonMenu.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonMenu.bottomAnchor.constraint(equalTo: self.buttonRetry.topAnchor, constant: -20),
         ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
