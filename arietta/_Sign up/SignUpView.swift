//
//  SignUpView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit

class SignUpView: UIView {
    
    var labelUserName: UILabel!
    var textFieldUserName: UITextField!

    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var labelConfirmPassword: UILabel!
    var textFieldConfirmPassword: UITextField!
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
        labelUserName = UILabel()
        labelUserName.translatesAutoresizingMaskIntoConstraints = false
        labelUserName.attributedText = UtilityFunctions.attributedBlackBodyText(text: "User Name", fontSize: 18)
        addSubview(labelUserName)
        
        textFieldUserName = UtilityFunctions.getTextField(placeholder: "Enter Your User Name")
        textFieldUserName.textContentType = .username
        textFieldUserName.autocapitalizationType = .none
        addSubview(textFieldUserName)
        
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
        
        labelConfirmPassword = UILabel()
        labelConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        labelConfirmPassword.attributedText = UtilityFunctions.attributedBlackBodyText(text: "Comfirm Password", fontSize: 18)
        addSubview(labelConfirmPassword)
        
        textFieldConfirmPassword = UtilityFunctions.getTextField(placeholder: "Re-enter Password")
        textFieldConfirmPassword.textContentType = .password
        textFieldConfirmPassword.isSecureTextEntry = true
        addSubview(textFieldConfirmPassword)
        
        buttonSignUp = UtilityFunctions.getFilledButton(title: "Sign Up")
        addSubview(buttonSignUp)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
//            labelEmail.topAnchor.constraint(equalTo: self.topAnchor, constant: 276),
//            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
//            
//            textFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 7),
            
            
            labelUserName.topAnchor.constraint(equalTo: self.topAnchor, constant: 244),
            labelUserName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            textFieldUserName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldUserName.topAnchor.constraint(equalTo: labelUserName.bottomAnchor, constant: 7),
            
            labelEmail.topAnchor.constraint(equalTo: textFieldUserName.bottomAnchor, constant: 32),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            textFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 7),
            
            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 32),
            labelPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            textFieldPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 7),
            
            labelConfirmPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            labelConfirmPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 52),
            
            textFieldConfirmPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldConfirmPassword.topAnchor.constraint(equalTo: labelConfirmPassword.bottomAnchor, constant: 7),
            
            buttonSignUp.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSignUp.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -38)
        ])
    }
}
