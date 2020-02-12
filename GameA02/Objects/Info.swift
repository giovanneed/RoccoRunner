//
//  Info.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-08.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Info : SKLabelNode {
    override init() {
        super.init()
    }
    
    override init(fontNamed fontName: String?) {
        super.init(fontNamed: fontName)
    }
  
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func setup(){
        
        self.text = "0000 m"
        self.fontSize = 25
        self.zPosition = 3
        self.position = CGPoint(x: -220, y: 130)
        self.fontName = "Press Start 2P"
        self.fontColor = UIColor(displayP3Red: 238/255.0, green: 220/255.0, blue: 32/255.0, alpha: 1)
        
    }
    
    func setupScore(){
           
           self.fontSize = 10
           self.zPosition = 3
           self.position = CGPoint(x: -280, y: 115)
           self.fontName = "Press Start 2P"
           self.fontColor = UIColor(displayP3Red: 238/255.0, green: 220/255.0, blue: 32/255.0, alpha: 1)
           
       }
    
  
      
    
}
