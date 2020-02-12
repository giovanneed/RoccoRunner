//
//  Backup.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-08.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation


//func runCycle()->[SKTexture] {
//         
//         var runFrames: [SKTexture] = []
//
//         for i in 1...29 {
//             let playerTextureName = "PlayerRun_\(i)"
//             print(playerTextureName)
//             runFrames.append( SKTexture(imageNamed: playerTextureName))
//
//         }
//         
//         return runFrames
//     }
/*
 
 func jump2(){
        
        var location = player.frame
        location.origin.y += 100
        let l = CGPoint(x: player.frame.origin.x, y:    player.frame.origin.y+40)
        let moveAction = SKAction.move(to: l, duration:(TimeInterval(1)))

        
        let jumpFrames : [SKTexture] = jumpCycle()
        
        player.run(moveAction)

        player.run(SKAction.repeatForever(
                  SKAction.animate(with: jumpFrames,
                                   timePerFrame: 0.08,
                                   resize: false,
                                   restore: true)),
                  withKey:"run")

    }
    func run2(){
        print("ruunn")
        
        let texture01 = SKTexture(imageNamed: "PlayerRun_03")
        let texture02 = SKTexture(imageNamed: "PlayerRun_26")
        let texture03 = SKTexture(imageNamed: "PlayerRun_40")
        let texture04 = SKTexture(imageNamed: "PlayerRun_60")

                let action1 = SKAction.setTexture(SKTexture(imageNamed: "PlayerRun_03"))
               let action2 = SKAction.setTexture(SKTexture(imageNamed: "PlayerRun_26"))
               let action3 = SKAction.setTexture(SKTexture(imageNamed: "PlayerRun_40"))
               let action4 = SKAction.setTexture(SKTexture(imageNamed: "PlayerRun_60"))

        let frames : [SKTexture] = [texture01,texture02,texture03,texture04]
               let seq = SKAction.sequence([action1,action2,action3,action4])
               let loop:SKAction = SKAction.repeatForever(seq)
        
        
        let runFrames : [SKTexture] = runCycle()

        player.run(SKAction.repeatForever(
           SKAction.animate(with: runFrames,
                            timePerFrame: 0.08,
                            resize: false,
                            restore: true)),
           withKey:"run")

                   //  player.run(loop)
    }
    
    func buildPlayer() {
      let bearAnimatedAtlas = SKTextureAtlas(named: "BearImages")
      var walkFrames: [SKTexture] = []

      let numImages = bearAnimatedAtlas.textureNames.count
      for i in 1...numImages {
        let bearTextureName = "bear\(i)"
        walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
      }
      playerRunningFrames = walkFrames
    }
 func run(){
       
       let runTextures = rocco.getTextureWithName("rocco_run_", frames: 6)

             rocco.actWithTextures(runTextures, timePerFrame: 0.1)
       
   }
   
   func jumpCycle()->[SKTexture] {
       
       var jumpFrames: [SKTexture] = []

       for i in 1...49 {
           let playerTextureName = "PlayerJump_\(i)"
           print(playerTextureName)
           jumpFrames.append( SKTexture(imageNamed: playerTextureName))

       }
       
       return jumpFrames
   }
   
   func runCycle()->[SKTexture] {
       
       var runFrames: [SKTexture] = []

       for i in 1...29 {
           let playerTextureName = "PlayerRun_\(i)"
           print(playerTextureName)
           runFrames.append( SKTexture(imageNamed: playerTextureName))

       }
       
       return runFrames
   }
 
 
 
 
 
 
 
 */
