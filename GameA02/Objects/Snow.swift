//
//  Snow.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-12.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Snow : SKShapeNode {
    override init() {
        super.init()
    }
  
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func setup(){

        self.fillColor = UIColor(displayP3Red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.6)
        self.zPosition = 4
        
        
        let x = Int.random(in: Int(-1*UIScreen.main.bounds.width/2)..<Int(UIScreen.main.bounds.width/2))

        print(x)

        self.position = CGPoint(x: CGFloat(x), y: UIScreen.main.bounds.height/2)
        
        let fall = SKAction.moveBy(x: CGFloat(x-30), y:-1*UIScreen.main.bounds.height, duration:2)
        
        let done = SKAction.run({ [weak self] in
                             self?.removeFromParent()

        })
        
        let seq = SKAction.sequence([fall, done])
        
        // make player run sequence
        self.run(seq)


  
        //self.physicsBody  = SKPhysicsBody(edgeChainFrom: self.path!)
            // self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.size.width)

       // self.physicsBody?.affectedByGravity = true
      
        //self.physicsBody?.isDynamic = true
        
        
    }
    
  
      
    
}
