//
//  ViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/19/24.
//

import UIKit

class ViewController: UIViewController {
    
    let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

