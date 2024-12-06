//
//  LaunchView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit

class LaunchView: UIView {

    var labelTitle: UILabel!
    var buttonSignIn: UIButton!
    var buttonSignUp: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named:"AriettaBackgroundColor")
        
        setupComponents()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.text = "Arietta"
        labelTitle.font = UIFont(name: "Besley-ExtraBoldItalic", size: 60)
        self.addSubview(labelTitle)
        
        buttonSignIn = UtilityFunctions.getFilledButton(title: "Sign In")
        self.addSubview(buttonSignIn)
        
        buttonSignUp = UIButton()
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        buttonSignUp.setAttributedTitle(UtilityFunctions.attributedBlackBodyText(text: "New to Arietta?", fontSize: 18), for: .normal)
        self.addSubview(buttonSignUp)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 298),
            
            buttonSignUp.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSignUp.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -103),
            
            buttonSignIn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSignIn.bottomAnchor.constraint(equalTo: buttonSignUp.topAnchor, constant: -24)
        ])
    }
}
