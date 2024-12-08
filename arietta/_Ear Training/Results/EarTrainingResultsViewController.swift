//
//  EarTrainingResultsViewController.swift
//  arietta
//
//  Created by Christina Kang on 12/4/24.
//

import UIKit

class EarTrainingResultsViewController: UIViewController {
    
    let ETResultsView = EarTrainingResultsView()
    
    var score: Int
    var selectedDifficulty: Int
  
    init(score: Int, selectedDifficulty: Int) {
        self.score = score
        self.selectedDifficulty = selectedDifficulty
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = ETResultsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Results")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
        
        ETResultsView.labelScore.text = "\(score)/5"
        
        ETResultsView.buttonRetry.addTarget(self, action: #selector(tapRetryButton), for: .touchUpInside)
        ETResultsView.buttonMenu.addTarget(self, action: #selector(tapMenuButton), for: .touchUpInside)
        
    }
    
    @objc func tapRetryButton(){
        let ETChooseLevel = EarTrainingChooseLevelViewController()
        navigationController?.pushViewController(ETChooseLevel, animated: true)
            
    }
    
    @objc func tapMenuButton(){
        let homeView = ViewController()
        navigationController?.pushViewController(homeView, animated: true)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
