//
//  Player.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-02.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit





class Player: SKSpriteNode {
    let spritesName : String  = "rooco"
    
    var flagJump = false
    var flagHitted = false

  
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        self.position = CGPoint(x: -200, y: -80)
        self.size.height = 80
        self.size.width = 80
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/3)
        self.physicsBody?.contactTestBitMask = 0x00000001
        self.zPosition = 2
        self.physicsBody?.allowsRotation = false
        self.name = "player"
      

    }
    
    func move(speed: Double){
        if flagHitted == true {return}
         self.position.x += CGFloat(speed)
        

     }
     
    
    func run(){
        
        self.removeAllActions()
        self.flagHitted = false
        self.flagJump = false


        
        let runTextures = self.getTextureWithName("rocco_run_", frames: 6)
        self.actWithTextures(runTextures, timePerFrame: 0.1)

    }
    
    func dead(){
           
        self.removeAllActions()
        self.flagHitted = false
        self.flagJump = false

           
           let textures = self.getTextureWithName("rocco_dead_", frames: 7)
        
        let doneAction = SKAction.run({ [weak self] in
            self?.texture = SKTexture(imageNamed: "rocco_dead_7")
        })
        
        
        let action = SKAction.animate(with: textures,
                                                   timePerFrame: 0.1,
                                                   resize: false,
                                                   restore: true)
               
               let sequence = SKAction.sequence([action,doneAction])
               self.run(sequence)

    }
    
    func hitted(){
        if flagHitted == true { return }
        flagHitted = true
             
        self.removeAllActions()

        let textures = self.getTextureWithName("rocco_hit_", frames: 2)

      
        let doneAction = SKAction.run({ [weak self] in
                   self?.run()
            self?.flagHitted = false

        })
        
        let hittedAction = SKAction.animate(with: textures,
                                            timePerFrame: 0.5,
                                            resize: false,
                                            restore: true)
        
        let sequence = SKAction.sequence([hittedAction,doneAction])
        self.run(sequence)


      }
    
    func jump(){
        
        if self.flagJump == true { return }
           
           self.flagJump = true
           
           self.removeAllActions()
           
           let jumpUpTextureAction = SKAction.run({ [weak self] in
            self?.texture = SKTexture(imageNamed: "rocco_jump_1")
           })
           
           let jumpDownTextureAction = SKAction.run({ [weak self] in
               self?.texture = SKTexture(imageNamed: "rocco_jump_2")

           })
           
           let jumpDoneAction = SKAction.run({ [weak self] in
                      self?.run()
                      self?.flagJump = false

           })
           
           // move up 20
           let jumpUpAction = SKAction.moveBy(x: 0, y:200, duration:0.5)
           // move down 20
           let jumpDownAction = SKAction.moveBy(x: 0, y:-200, duration:0.5)
           // sequence of move yup then down
           let jumpSequence = SKAction.sequence([jumpUpTextureAction, jumpUpAction,jumpDownTextureAction,jumpDownAction, jumpDoneAction])

           // make player run sequence
           self.run(jumpSequence)
           
           
       }
    
    
    func isOutOfScreen()->Bool {
     
           
           return self.position.x < -1*UIScreen.main.bounds.width/2
    }
    
  
       
}

