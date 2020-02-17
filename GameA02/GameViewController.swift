//
//  GameViewController.swift
//  GameA02
//
//  Created by gio emiliano on 2020-01-28.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var sceneMenager: SceneManager?

    var gameScene : SKScene?
    var menuScene : SKScene?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentScene(sceneName: "Menu")
        
     
    }
    
    func presentScene(sceneName: String){
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: sceneName) as?  Menu {
                // Set the scale mode to scale to fit the window
                scene.sceneMenager = self

                
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
              
            }
            
            if let scene = SKScene(fileNamed: sceneName) as?  GameScene {
                // Set the scale mode to scale to fit the window
                scene.sceneMenager = self
                
                
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
            }
            
            view.ignoresSiblingOrder = true
            
        }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


extension GameViewController : SceneManager {
    
    
    func backToMenu() {
        
        presentScene(sceneName: "Menu")

        
        
    }
    
    func showGameScene() {
        presentScene(sceneName: "GameScene")
    }
}
