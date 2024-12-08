//
//  SightReadingResultsViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/8/24.
//

import UIKit

class SightReadingResultsViewController: UIViewController {

    let SRResultsView = SightReadingResultsView()
   
    var result = 4

    override func loadView() {
        view = SRResultsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SRResultsView.labelResult.text = String(result)
        SRResultsView.buttonRetry.addTarget(self, action: #selector(onButtonRetryTapped), for: .touchUpInside)
        SRResultsView.buttonMainMenu.addTarget(self, action: #selector(onButtonMainMenuTapped), for: .touchUpInside)
        
    }
    
    @objc func onButtonRetryTapped() {
//        let SRChooseLevelVC = SightReadingChooseLevelViewController()
//        navigationController?.pushViewController(SRChooseLevelVC, animated: true)
        if let viewControllers = self.navigationController?.viewControllers {
            if viewControllers.count > 1 {
                let SRlevelVC = viewControllers[1] //
                self.navigationController?.popToViewController(SRlevelVC, animated: true)
            }
        }
    }
    
    @objc func onButtonMainMenuTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
