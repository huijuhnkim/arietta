//
//  SignInViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    let signInView = SignInView()
    
    override func loadView() {
        view = signInView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Sign In")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()

        // implement buttonSignIn.addTarget
        
        // implement buttonForgotPassword.addTarget
    }

}
