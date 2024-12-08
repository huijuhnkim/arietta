//
//  ProgressReportViewController.swift
//  arietta
//
//  Created by Christina Kang on 12/8/24.
//

import UIKit

class ProgressReportViewController: UIViewController {

    let progressReport = ProgressReportView()
    
    var score: Int
  
    init(score: Int) {
        self.score = score
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = progressReport
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newNavigationTitle = UILabel()
        let attributedTitle = UtilityFunctions.attributedNavigationTitle(text: "Progress Report")
        newNavigationTitle.attributedText = attributedTitle
        navigationItem.titleView = newNavigationTitle
        
      
        
        //ETResultsView.buttonRetry.addTarget(self, action: #selector(tapRetryButton), for: .touchUpInside)
        //ETResultsView.buttonMenu.addTarget(self, action: #selector(tapMenuButton), for: .touchUpInside)
        
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
