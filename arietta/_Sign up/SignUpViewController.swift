//
//  SignUpViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit
import FirebaseAuth
import Firebase


class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = signUpView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Sign Up")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // implement buttonSignUp.addTarget
        signUpView.buttonSignUp.addTarget(self, action: #selector(onButtonSignUpTapped), for: .touchUpInside)
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    
    @objc func onButtonSignUpTapped(){
        // showActivityIndicator()
        
        if let username = signUpView.textFieldUserName.text,
           let email = signUpView.textFieldEmail.text,
           let password = signUpView.textFieldPassword.text,
           let confirmPassword = signUpView.textFieldConfirmPassword.text {

            // input validations
            if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                displayAlert(viewController: self, title: "Empty Fields", message: "There are empty fields. Please fill in all fields.")
                // self.hideActivityIndicator()
                return
            }
            
            if !isValidEmail(email: email) {
                displayAlert(viewController: self, title: "Invalid Email", message: "Email should be in proper format.")
                // self.hideActivityIndicator()
                return
            }
            
            if password != confirmPassword {
                displayAlert(viewController: self, title: "Password Mismatch", message: "Password does not match.")
                // self.hideActivityIndicator()
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    displayAlert(viewController: self, title: "Registration Error", message: error.localizedDescription)
                    // self.hideActivityIndicator()
                } else if let user = authResult?.user {
                    print("add user to fire store")
                    self.addUserToFirestore(user: user, name: username, email: email)
                }
            }
        }
    }
    
    func addUserToFirestore(user: FirebaseAuth.User, name: String, email: String) {
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).setData([
            "name": name,
            "email": email,
            "uid": user.uid,
        ]) { error in
            if let error = error {
                displayAlert(viewController: self, title: "Firestore Error", message: error.localizedDescription)
                // self.hideActivityIndicator()
            } else {
                print("set name of the user in firebase auth")
                // self.setNameOfTheUserInFirebaseAuth(name: name, user: user)
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    if let error = error {
                        displayAlert(viewController: self, title: "Profile Update Error", message: error.localizedDescription)
                        // self.hideActivityIndicator()
                    } else {
                        print("jump to main view")
                        if let viewControllers = self.navigationController?.viewControllers {
                            for viewController in viewControllers {
                                if let mainVC = viewController as? ViewController {
                                    self.navigationController?.popToViewController(mainVC, animated: true)
                                    break
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension SignUpViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
