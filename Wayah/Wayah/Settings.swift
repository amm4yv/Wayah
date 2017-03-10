//
//  Settings.swift
//  Wayah
//
//  Created by Allison Moyer on 3/9/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import Foundation

class Settings: NSObject {
    let numTeams: Int!
    let timeLimit: Int!
    let allowSkipping: Bool!
    
    init(numTeams: Int = 2, timeLimit: Int = 60, allowSkipping: Bool = true) {
        self.numTeams = numTeams
        self.timeLimit = timeLimit
        self.allowSkipping = allowSkipping
    }
    
}
