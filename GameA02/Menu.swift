//
//  Menu.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-11.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation


class Menu: SKScene {
    
    var backgroundAudioPlayer: AVAudioPlayer?

    
    var start = Button()

    
    override func didMove(to view: SKView) {
           
        backgroundSound(sound: "gods_plan.mp3")

        
        start = Button(imageNamed: "start")
        start.setup(width: 150, height: 60)
        
        addChild(start)
        
        
        
        
        let logo = SKSpriteNode(imageNamed: "name-menu")
        logo.position = CGPoint(x: -500, y: 100)
        logo.size = CGSize(width: 400, height: 50)
        logo.zPosition = 3
        
        
        let slide = SKAction.move(to: CGPoint(x: 0, y: 100), duration: 1)//By(x: 0, y:0, duration:0.5)
        
        logo.run(slide)

        addChild(logo)
        
        let rocco = SKSpriteNode(imageNamed: "rocco-menu1")
        rocco.position = CGPoint(x: -200, y: 0)
        rocco.size = CGSize(width: 120, height: 120)
        rocco.zPosition = 3
        
        


        
        rocco.run(SKAction.repeatForever(
               SKAction.animate(with: [SKTexture(imageNamed: "rocco-menu1"),SKTexture(imageNamed: "rocco-menu2")],
                                timePerFrame: 1,
                                resize: false,
                                restore: true)),
               withKey:"run")
        
        
        
        addChild(rocco)
            
     
       }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched")
        
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        
        if let name = touchedNode.name
        {
            if name == "restart"
            {
                print("Touched")
                
                if let view = self.view as! SKView? {
                    
                    if let scene = SKScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        view.presentScene(scene)
                    }
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
            
            
        }
        
    }
    
    func backgroundSound(sound: String){
        
        
        let path = Bundle.main.path(forResource: sound, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundAudioPlayer?.volume = 0.3
            
            backgroundAudioPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
           
           
           
           
}
