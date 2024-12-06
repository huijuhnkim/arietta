//
//  SignInView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit

class SignInView: UIView {

    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    
    var buttonSignIn: UIButton!
    var buttonForgotPassword: UIButton!
    
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
        
        labelPassword = UILabel()
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        labelPassword.attributedText = UtilityFunctions.attributedBlackBodyText(text: "Password", fontSize: 18)
        addSubview(labelPassword)
        
        textFieldPassword = UtilityFunctions.getTextField(placeholder: "Enter Your Password")
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        addSubview(textFieldPassword)
        
        buttonSignIn = UtilityFunctions.getFilledButton(title: "Sign In")
        addSubview(buttonSignIn)
        
        buttonForgotPassword = UIButton()
        buttonForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        buttonForgotPassword.setAttributedTitle(
            UtilityFunctions.attributedBlackBodyText(text: "Forgot Password?", fontSize: 18), for: .normal)
        addSubview(buttonForgotPassword)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelEmail.topAnchor.constraint(equalTo: self.topAnchor, constant: 331),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            textFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 7),
            
            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 32),
            labelPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            textFieldPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 7),
            
            buttonForgotPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonForgotPassword.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -54),
            
            buttonSignIn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSignIn.bottomAnchor.constraint(equalTo: buttonForgotPassword.topAnchor, constant: -24)
        ])
    }
}
