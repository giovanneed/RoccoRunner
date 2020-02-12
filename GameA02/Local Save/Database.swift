//
//  Database.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-12.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation


class Scoreboard {
    
    func saveBest(score: Int) {
        UserDefaults.standard.set(score,forKey: "best")
        UserDefaults.standard.synchronize()

    }
    
    func getBest()->Int {
        if let best = UserDefaults.standard.value(forKey: "best") as? Int {
           return best
        }
        return 0
    }
}
