//
//  Floor.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-08.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//


import Foundation
import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Floor : SKShapeNode {
    override init() {
        super.init()
    }
  
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func setup(){

        self.fillColor = UIColor(displayP3Red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1)
        self.zPosition = 1
        self.position = CGPoint(x: -UIScreen.main.bounds.width/2, y: -150)

  
        self.physicsBody  = SKPhysicsBody(edgeChainFrom: self.path!)
      
        self.physicsBody?.isDynamic = false
        
        
    }
    
  
      
    
}
