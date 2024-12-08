//
//  SightReadingResultsViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/8/24.
//

import UIKit

class SightReadingResultsViewController: UIViewController {

    let SRResultsView = SightReadingResultsView()
    
    override func loadView() {
        view = SRResultsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SRResultsView.buttonRetry.addTarget(self, action: #selector(onButtonRetryTapped), for: .touchUpInside)
    }
    
    @objc func onButtonRetryTapped() {
        let SRChooseLevelVC = SightReadingChooseLevelViewController()
        navigationController?.pushViewController(SRChooseLevelVC, animated: true)
    }
}
