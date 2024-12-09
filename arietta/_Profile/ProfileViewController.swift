//
//  ProfileViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/8/24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.buttonSignOut.addTarget(self, action: #selector(onButtonSignOutTapped), for: .touchUpInside)
    }
    
    @objc func onButtonSignOutTapped() {
        let logoutAlert = UIAlertController(title: "Sign Out", message: "Are you sure want to sign out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Sign Out", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
}
