//
//  Powerup.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-12.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit


class Powerup : SKSpriteNode {
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
          super.init(texture: texture, color: color, size: size)

      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func setup(withPosition p: CGFloat){
        
        let w = Int(UIScreen.main.bounds.width) * 2 + Int(p)
        print("width: \(w)")
        let random = Int(arc4random_uniform(UInt32(w))+1)
        
        print(random)
        
        self.zPosition = 3
        self.position.y = 0//UIScreen.main.bounds.height
        self.position.x =  UIScreen.main.bounds.width 
        self.size.height = 30
        self.size.width = 30

        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height), center: CGPoint(x: 0, y: 0))
        self.physicsBody?.density = 0//isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false

        self.name = "powerup"
        
        
    }
    
    func move(speed: Double){
        self.position.x -= CGFloat(speed)

    }
    
       
    
    
    func isOutOfScreen()->Bool {
           
           return self.position.x < -1*UIScreen.main.bounds.width
    }
    
 
      
    
}
