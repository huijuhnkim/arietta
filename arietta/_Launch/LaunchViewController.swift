//
//  LaunchViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/2/24.
//

import UIKit

class LaunchViewController: UIViewController {
    
    let launchView = LaunchView()
    
    override func loadView() {
        view = launchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        launchView.buttonSignIn.addTarget(self, action: #selector(handleButtonSignIn), for: .touchUpInside)
        launchView.buttonSignUp.addTarget(self, action: #selector(handleButtonSignUp), for: .touchUpInside)
    }
    
    @objc func handleButtonSignIn() {
        let signInViewController = SignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    @objc func handleButtonSignUp() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
