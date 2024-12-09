//
//  File.swift
//  arietta
//
//  Created by Christina Kang on 12/8/24.
//

import Foundation
struct ETResult: Codable {
    let date: String
    let difficulty: Int
    let score: Int
    
    init(date:String, difficulty: Int, score: Int){
        self.date = date
        self.difficulty = difficulty
        self.score = score
    }
    
}

struct ETResults: Codable{
    let etResults: [ETResult]
}
