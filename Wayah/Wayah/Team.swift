//
//  Team.swift
//  Wayah
//
//  Created by Allison Moyer on 3/9/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import Foundation

class Team: NSObject, Comparable {
    var id: Int
    var score: Int = 0
    var numSkips: Int = 0
    
    init(id: Int) {
        self.id = id
    }
    
//    func selectedCorrectItem() {
//        score += 1
//    }
//    
//    func skippedItem() {
//        numSkips += 1
//    }
//    
    func addToScore(_ number: Int) {
        score += number
    }
    
    func addToSkipped(_ number: Int) {
        numSkips += number
    }
    
    static func <(lhs: Team, rhs: Team) -> Bool {
        return lhs.score < rhs.score
    }
}
