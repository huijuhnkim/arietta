//
//  SightReadingExerciseViewController.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/5/24.
//

import UIKit

class SightReadingExerciseViewController: UIViewController {

    let SRExerciseView = SightReadingExerciseView()
    
    override func loadView() {
        view = SRExerciseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
