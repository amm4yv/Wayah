//
//  Data.swift
//  Wayah
//
//  Created by Allison Moyer on 4/25/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import Foundation

struct Settings {
    let numTeams: Int!
    let timeLimit: Int!
    let allowSkipping: Bool!
    
    init(t: Int, l: Int, s: Bool) {
        numTeams = t
        timeLimit = l
        allowSkipping = s
    }
    
}

class BowlItem: NSObject {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}


class Game: NSObject {
    static let data = Game()
    
    var bowl1: [BowlItem] = []
    var bowl2: [BowlItem] = []
    var round = 1
    var settings = Settings(t: 0, l: 0, s: false)
    var scores = Scoreboard()
    
    func add(item: BowlItem) {
        bowl1.append(item)
    }
    
    func update(text: String, index: Int) {
        bowl1[index].text = text
    }
    
    func move(index: Int) {
        bowl2.append(bowl1.removeAtIndex(index))
        print("Bowl 1: \(bowl1)")
        print("Bowl 2: \(bowl2)")
    }
    
    func reset() {
        for i in 1...bowl2.count {
            bowl1.append(bowl2[i-1])
        }
        bowl2.removeAll(keepCapacity: true)
        round += 1
    }
    
    func newGame() {
        bowl1 = []
        bowl2 = []
        round = 1
        settings = Settings(t: 0, l: 0, s: false)
        scores = Scoreboard()
    }
    
}

struct Scoreboard {
    var data: [Int] = []
    
    mutating func create(numberOfTeams: Int){
        data = [Int](count: numberOfTeams, repeatedValue: 0)
    }
    
    mutating func increase(team: Int){
        data[team] += 1
    }
    
}