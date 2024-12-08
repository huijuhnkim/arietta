//
//  EarTrainingChooseLevelViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/30/24.
//

import UIKit

class EarTrainingChooseLevelViewController: UIViewController  {
    let ETChooseLevelView = EarTrainingChooseLevelView()
    var selectedDifficulty: Int?
    
    override func loadView() {
        view = ETChooseLevelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Ear Training")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
        
        ETChooseLevelView.buttonLevelOne.addTarget(self, action: #selector(tapLevelOne), for: .touchUpInside)
        ETChooseLevelView.buttonLevelTwo.addTarget(self, action: #selector(tapLevelTwo), for: .touchUpInside)
        ETChooseLevelView.buttonLevelThree.addTarget(self, action: #selector(tapLevelThree), for: .touchUpInside)
        ETChooseLevelView.buttonStart.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)

    }
    
    @objc func tapLevelOne() {
        selectedDifficulty = 1
    }
    
    @objc func tapLevelTwo() {
        selectedDifficulty = 2
    }
    
    @objc func tapLevelThree() {
        selectedDifficulty = 3
    }
    
    @objc func tapStartButton() {
        
        // go to exercise screen with selected level
        let ETExerciseViewController = EarTrainingExerciseViewController(selectedDifficulty: selectedDifficulty ?? 1)
        //ETExerciseViewController.selectedDifficulty = selectedDifficulty ?? 1
        navigationController?.pushViewController(ETExerciseViewController, animated: true)
    }

}
