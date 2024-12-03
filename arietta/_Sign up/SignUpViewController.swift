//
//  SignUpViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    
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
    }
}
