//
//  SightReadingExercise.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/7/24.
//

import Foundation
import UIKit

struct SightReadingExercise {
    let scoreName: String
    let correctNotes: [String]
    let scoreImage: UIImage
    
    // Initialize an exercise with a score image and correct notes
    init?(scoreName: String, correctNotes: [String]) {
        guard let image = UIImage(named: scoreName) else {
            print("Could not load image with name: \(scoreName)")
            return nil
        }
        
        self.scoreName = scoreName
        self.correctNotes = correctNotes
        self.scoreImage = image
    }
}
