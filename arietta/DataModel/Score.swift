//
//  Score.swift
//  arietta
//
//  Created by Charles Yang on 12/8/24.
//

import UIKit

struct ScoreData: Codable {
    let score: String
    let notes: [String]
}

struct Scores: Codable {
    let level1: [ScoreData]
    let level2: [ScoreData]
    let level3: [ScoreData]
}
