//
//  Button.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-09.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Button : SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
          super.init(texture: texture, color: color, size: size)

      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func setup(width: CGFloat, height: CGFloat, name: String){
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = CGSize(width: width, height: height * 0.9)
        self.position = CGPoint(x: frame.midX, y: frame.midY)
        zPosition = 3
        self.name = name
        
        
    }
    
    func setupPause(){
        
        self.size = CGSize(width: 40, height:40)
        self.position = CGPoint(x: UIScreen.main.bounds.width/2 - 200, y: UIScreen.main.bounds.height/2 - 80)
        zPosition = 3
        self.name = "pause"
        
        
    }
    

  
      
    
}

