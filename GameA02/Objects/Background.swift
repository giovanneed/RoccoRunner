//
//  Background.swift
//  GameA02
//
//  Created by gio emiliano on 2020-02-08.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//



import Foundation
import UIKit
import SpriteKit
import GameplayKit

class Background : SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
          super.init(texture: texture, color: color, size: size)

      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func setup(width: CGFloat, height: CGFloat, index: Int, name:String){
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = CGSize(width: width, height: height * 0.9)
        self.position.x = index == 1 ? 0 : width
        self.position.y += 40
        self.name = name
        
        
    }
    
    func move(speed: Double){
        self.position.x -= CGFloat(speed)

    }
    
    func isOutOfScreen() {
        
        if self.position.x < -1*self.size.width {
            self.position.x = self.size.width

        }
    }
    
  
      
    
}
