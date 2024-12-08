//
//  SignInViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    let signInView = SignInView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                // not signed in...
                self.currentUser = nil
                return
            } else {
                // user is signed in
                self.currentUser = user
                return
            }
        }
    }
    
    override func loadView(){
        view = signInView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Sign In")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()

        // implement buttonSignIn.addTarget
        signInView.buttonSignIn.addTarget(self, action: #selector(onButtonSignInTapped), for: .touchUpInside)
        
        // implement buttonSignUp.addTarget
        signInView.buttonSignUp.addTarget(self, action: #selector(onButtonSignUpTapped), for: .touchUpInside)
        
        // implement buttonForgotPassword.addTarget
        signInView.buttonForgotPassword.addTarget(self, action: #selector(onButtonForgotPasswordTapped), for: .touchUpInside)
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onButtonSignInTapped(){
        if let email = signInView.textFieldEmail.text, let password = signInView.textFieldPassword.text {
            
            // text fields should not be empty
            if email.isEmpty || password.isEmpty {
                displayAlert(viewController: self, title: "Empty Fields", message: "Please fill in all text fields.")
                return
            }
            
            // perform authentication
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
//                    case .wrongPassword:
//                        displayAlert(viewController: self, title: "Wrong Password", message: "Wrong password. Please try again.")
                    case .invalidEmail:
                        displayAlert(viewController: self, title: "Invalid Email", message: "Invalid email. Please try again.")
//                    case .userNotFound:
//                        print("user not found")
//                        displayAlert(viewController: self, title: "User Not Found", message: "There is no user with this email. Please register.")
                    default:
                        print("Error: \(error.localizedDescription)")
                        displayAlert(viewController: self, title: "Wrong email or password!", message: "Incorrect email or password. Please try again.")
                        return
                    }
                } else {
                    print("User signed in successfully.")
                    self.currentUser = authResult!.user
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @objc func onButtonSignUpTapped(){
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @objc func onButtonForgotPasswordTapped(){
        let forgotPasswordViewController = ForgotPasswordViewController()
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }

}
