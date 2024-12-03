//
//  ViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/19/24.
//

import UIKit

class ViewController: UIViewController {
    
    let homeView = HomeView()
    let launchView = LaunchView()
    let signUpView = SignUpView()
    let signInView = SignInView()
    
    override func loadView() {
        view = signInView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Arietta")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
        
        homeView.buttonEarTraining.addTarget(self, action: #selector(handleButtonEarTraining), for: .touchUpInside)
        homeView.buttonSightReading.addTarget(self, action: #selector (handleButtonSightReading), for: .touchUpInside)
    }
    
    @objc func handleButtonEarTraining() {
        let ETChooseLevelVC = EarTrainingChooseLevelViewController()
        navigationController?.pushViewController(ETChooseLevelVC, animated: true)
    }
    
    @objc func handleButtonSightReading() {
        let SRChooseLevelVC = SightReadingChooseLevelViewController()
        navigationController?.pushViewController(SRChooseLevelVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

