//
//  Scoreboard.swift
//  Wayah
//
//  Created by Allison Moyer on 4/25/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import Foundation

class Scoreboard: NSObject {
    var data: [Int] = []
    
    func create(numberOfTeams: Int){
        data = [Int](repeating: 0, count: numberOfTeams)
    }
    
    func increaseTeamScoreAtIndex(teamIndex: Int){
        data[teamIndex] += 1
    }
    
}






