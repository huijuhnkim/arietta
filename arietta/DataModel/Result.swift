//
//  Result.swift
//  arietta
//
//  Created by Charles Yang on 12/8/24.
//

import Foundation
struct Result: Codable {
    let date: Date
    let difficulty: Int
    let score: Int
    
    init(date:Date, difficulty: Int, score: Int){
        self.date = date
        self.difficulty = difficulty
        self.score = score
    }
    
}

struct Results: Codable{
    let Results: [Result]
}
