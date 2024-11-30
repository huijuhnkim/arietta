//
//  EarTrainingChooseLevelViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/30/24.
//

import UIKit

class EarTrainingChooseLevelViewController: UIViewController {
    
    let ETChooseLevelView = EarTrainingChooseLevelView()
    
    override func loadView() {
        view = ETChooseLevelView
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Ear Training")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
