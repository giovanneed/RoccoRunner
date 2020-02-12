//
//  Extension.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-08.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

extension SKNode {
    
    func getTextureWithName(_ name:String, frames: Int)->[SKTexture] {
            
            var textures: [SKTexture] = []

            for i in 1...frames {
                let playerTextureName = name + "\(i)"
               // print(playerTextureName)
                textures.append( SKTexture(imageNamed: playerTextureName))

            }
            
            return textures
    }
    
    func actWithTextures(_ textures:[SKTexture], timePerFrame: Double ){
        self.run(SKAction.repeatForever(
        SKAction.animate(with: textures,
                         timePerFrame: timePerFrame,
                         resize: false,
                         restore: true)),
        withKey:"run")
    }
}


extension Array where Element: Equatable{
    mutating func remove (element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}


