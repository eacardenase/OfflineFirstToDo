//
//  PlayerViewModel.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

@Observable
class PlayerViewModel {
    var name: String
    var score: Int?
    
    init(name: String, score: Int? = nil) {
        self.name = name
        self.score = score
    }
}
