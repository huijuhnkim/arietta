//
//  ForgotPasswordViewController.swift
//  arietta
//
//  Created by Charles Yang on 12/8/24.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    let forgotPasswordView = ForgotPasswordView()
    
    override func loadView() {
        view = forgotPasswordView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Forgot Password")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up button action
        forgotPasswordView.buttonResetPassword.addTarget(self, action: #selector(onButtonResetPasswordTapped), for: .touchUpInside)
        
        // Dismiss keyboard on tap
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onButtonResetPasswordTapped() {
        if let email = forgotPasswordView.textFieldEmail.text {
            // Check if the email field is empty
            if email.isEmpty {
                displayAlert(viewController: self, title: "Empty Field", message: "Please enter your email address.")
                return
            }
            
            // Validate email format
            if !isValidEmail(email: email) {
                displayAlert(viewController: self, title: "Invalid Email", message: "Please enter a valid email address.")
                return
            }
            
            // Send password reset email
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    displayAlert(viewController: self, title: "Error", message: error.localizedDescription)
                } else {
                    self.displaySuccessAndPop()
                }
            }
        }
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func displaySuccessAndPop() {
        let alert = UIAlertController(title: "Success", message: "A password reset link has been sent to your email address.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
