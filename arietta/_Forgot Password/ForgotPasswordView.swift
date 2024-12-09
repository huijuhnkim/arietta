//
//  ForgotPasswordView.swift
//  arietta
//
//  Created by Charles Yang on 12/8/24.
//

import UIKit

class ForgotPasswordView: UIView {
    
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var buttonResetPassword: UIButton!
    
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
        labelEmail = UILabel()
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.attributedText = UtilityFunctions.attributedBlackBodyText(text: "Email", fontSize: 18)
        addSubview(labelEmail)
        
        textFieldEmail = UtilityFunctions.getTextField(placeholder: "Enter Your Email")
        textFieldEmail.textContentType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        addSubview(textFieldEmail)
        
        buttonResetPassword = UtilityFunctions.getFilledButton(title: "Reset Password")
        addSubview(buttonResetPassword)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelEmail.topAnchor.constraint(equalTo: self.topAnchor, constant: 244),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            textFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 7),
            
            buttonResetPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonResetPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 32),
            buttonResetPassword.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -38)
        ])
    }
}


