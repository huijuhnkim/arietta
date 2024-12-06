//
//  EarTrainingChooseLevelViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/30/24.
//

import UIKit

class SightReadingChooseLevelViewController: UIViewController {
    
    let SRCChooseLevelView = SightReadingChooseLevelView()
    
    override func loadView() {
        view = SRCChooseLevelView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Sight Reading")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SRCChooseLevelView.buttonStart.addTarget(self, action: #selector(onButtonStartTapped), for:.touchUpInside)
    }
    
    @objc func onButtonStartTapped() {
        let SRExerciseVC = SightReadingExerciseViewController()
        navigationController?.pushViewController(SRExerciseVC, animated: true)
    }
}
