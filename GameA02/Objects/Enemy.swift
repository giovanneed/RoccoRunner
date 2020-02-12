//
//  Enemy.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-08.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Enemy : SKSpriteNode {
    
    var tag = 0
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
          super.init(texture: texture, color: color, size: size)

      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func setup(withPosition p: CGFloat){
        
        let w = Int(UIScreen.main.bounds.width) * 2 + Int(p)
        print("width: \(w)")
        //let random = Int(arc4random_uniform(UInt32(w))+1)
        let random = Int.random(in: Int(-1*UIScreen.main.bounds.width/2)..<Int(UIScreen.main.bounds.width/2))

        print(random)
        
        self.zPosition = 3
        self.position.y -= 110
        self.position.x =  UIScreen.main.bounds.width + CGFloat(random)
        self.size.height = 60
        self.size.width = 60

        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: 10), center: CGPoint(x: 0, y: -20))
        self.physicsBody?.density = 0//isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false

        self.name = "enemy"
        
        
    }
    
    func setupBin(){
        
        let w = Int(UIScreen.main.bounds.width) * 2
        print("width: \(w)")
        let random = Int(arc4random_uniform(UInt32(w))+1)
        
        print(random)
        
        self.zPosition = 3
        self.position.y -= 90
        self.position.x =  UIScreen.main.bounds.width //+ CGFloat(random)
        self.size.height = 80
        self.size.width = 50

        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height), center: CGPoint(x: 0, y: 0))
        self.physicsBody?.density = 0//isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false

        self.name = "bin"
        
        
    }
    
    func move(speed: Double){
        self.position.x -= CGFloat(speed)

    }
    
    func trigged(){
           
      self.removeAllActions()

      let textures = self.getTextureWithName("trap_", frames: 5)

    
      let doneAction = SKAction.run({ [weak self] in
                // self?.removeFromParent()
        self?.texture = SKTexture(imageNamed: "trap_5")

      })
      
      let action = SKAction.animate(with: textures,
                                          timePerFrame: 0.05,
                                          resize: false,
                                          restore: true)
      
      let sequence = SKAction.sequence([action,doneAction])
      self.run(sequence)


    }
    
    func close(){
        self.removeAllActions()
        
        let closeTrapTextures = self.getTextureWithName("trap_", frames: 5)

        
        let closeTextureAction = SKAction.run({ [weak self] in
            self?.actWithTextures(closeTrapTextures, timePerFrame: 0.1)
            

        })
        
        let doneAction = SKAction.run({ [weak self] in
                             self?.removeFromParent()

        })
        

          let closeSequence = SKAction.sequence([closeTextureAction, doneAction])
        
        self.run(closeSequence)


          
    }
    
    func isOutOfScreen()->Bool {
           
           return self.position.x < -1*UIScreen.main.bounds.width
    }
    
 
      
    
}
