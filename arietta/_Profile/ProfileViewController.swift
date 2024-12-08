//
//  ProfileViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/8/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
