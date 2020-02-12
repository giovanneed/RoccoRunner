//
//  GameScene.swift
//  GameA02
//
//  Created by gio emiliano on 2020-01-28.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var audioPlayer: AVAudioPlayer?

    var backgroundAudioPlayer: AVAudioPlayer?

    var bg1 = Background()
    var bg2 = Background()
    
    var bgStars = Background()

    
    var  rocco  = Player()
   // var  trap  = Enemy()
    var floor = Floor()
    
    var  traps  : [Enemy] = []
    var lastEnemyPosition = 0
    var trapsCount = 0

    var  coffee  = Powerup()
    var coffeSpawnCount = 0

    var  bins  : [Enemy] = []

    var binSpawnCount = 0
    var snowCount = 0

    
    var bestScore  = Info()

    var distance  = Info()
    var score = 0
    var life = 3
    
    
    var stop = false
    
    var restart = Button()
    
    var pause = Button()

    
    var viewWidth = CGFloat()
    var viewHeight = CGFloat()

    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.62)
        view.showsPhysics = true

        
        viewWidth = UIScreen.main.bounds.width
        viewHeight = UIScreen.main.bounds.height

        
        start()
        
        
       

  
    }
    
    func start(){
        
        
        
        coffeSpawnCount = 0
         binSpawnCount = 0
         snowCount = 0

        
        backgroundSound(sound: "music_bg.mp3")

        restart.removeFromParent()
        stop = false
        life = 3
        
        floor = Floor(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        
        floor.setup()
        addChild(floor)
        
        bgStars = Background(imageNamed: "stars_bg")
        bgStars.setup(width:viewWidth, height: viewHeight, index:1, name:"stars")
        bgStars.zPosition = -1
        addChild(bgStars)

        
        bg2 = Background(imageNamed: "background")
        bg1 = Background(imageNamed: "background")
        bg1.setup(width:viewWidth, height: viewHeight, index: 1, name:"background")
        bg2.setup(width: viewWidth, height: viewHeight, index: 2, name:"background")
        
        addChild(bg1)
        addChild(bg2)
        
        
        rocco = Player(imageNamed: "rocco_run_1")
        rocco.setup()
        rocco.run()
        
        addChild(rocco)
        
        spawnEnemy()
        spawnEnemy()
        spawnEnemy()

        distance = Info()
        distance.setup()
        
        addChild(distance)
        
        
        bestScore = Info()
        bestScore.setupScore()
        
        let best = Scoreboard().getBest()
        
        if best > 0 {
            bestScore.text = "Best:\(best) m"
            addChild(bestScore)

        }
        
        
        restart = Button(imageNamed: "play-again")
        restart.setup(width: 150, height: 60)
        
        
        pause = Button(imageNamed: "pause")
        pause.setupPause()
        
        addChild(pause)
        
        
        
    }
    
    func restartGame(){
        self.removeAllChildren()
        self.start()
    }
    
    func pauseGame() {
        if isPaused {
            
            pause.texture = SKTexture(imageNamed: "pause")
            backgroundAudioPlayer?.play()

            isPaused = false
        } else {
            pause.texture = SKTexture(imageNamed: "play")
            isPaused = true
            backgroundAudioPlayer?.pause()
        }
    }

    
    func finish(){
        backgroundSound(sound: "music_bg.mp3")

        stop = true
        rocco.dead()
        
        let best = Scoreboard().getBest()

        if score > best {
            Scoreboard().saveBest(score: score)
        }
        
        
        //backgroundAudioPlayer?.pause()
        restart.removeFromParent()
        addChild(restart)

        
    }
    
    func updateInfo(){
        
        var l = "❤️"
        if (life == 0) { l = ""}
        if (life == 2) { l = "❤️❤️"}
        if (life == 3) {l = "❤️❤️❤️"}

        distance.text = "\(score) m " + l
        
    }
    
    func checkNodeName(_ nodeA: SKNode, nodeB: SKNode, name: String ) -> SKNode? {
        if nodeA.name == name { return nodeA}
        if nodeB.name == name { return nodeB}
        
        return nil

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        

        

        
        let nodeCoffee = checkNodeName(nodeA, nodeB: nodeB, name: "powerup") as? Powerup
        let nodePlayer = checkNodeName(nodeA, nodeB: nodeB, name: "player") as? Player

        if (nodeCoffee != nil), (nodePlayer != nil) {
            if life < 3 { life += 1}
            updateInfo()
            nodeCoffee?.removeFromParent()
            coffeSpawnCount = 0
            return
        }

        if nodeA.name == "player" && nodeB.name == "enemy" || nodeA.name == "enemy" && nodeB.name == "player" {
            

            
            var t = Enemy()

            if let trap = nodeB as? Enemy {
                trap.trigged()
                t = trap
                
            }
            
            if let trap = nodeA as? Enemy {
                trap.trigged()
                t = trap
                
            }
            
            playSound(sound: "hit.mp3")

            
            life -= 1
            if life < 1 {
                t.removeFromParent()
                playSound(sound: "dead.mp3")
                updateInfo()

               finish()
            }else {
                rocco.hitted()

            }
        }

    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {
   
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    func checkTouch(touch: UITouch, node: String)->Bool {
        
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == node
            {
                return true
            }
        }
        
        
        
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if checkTouch(touch: touches.first!, node: "pause") {
            pauseGame()
            return

        }
        if stop  {
            let touch:UITouch = touches.first!
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "restart"
                {
                    restartGame()
                }
                
               
            }
            
            return
            
        }
        if rocco.flagJump == false {
            playSound(sound: "jump.mp3")
        }

        rocco.jump()
       



    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if stop  { return }
        
        
        if rocco.isOutOfScreen() {
            
            playSound(sound: "dead.mp3")
            updateInfo()
            
            finish()
            return
            
        }
        
        if rocco.position.x > 0 {
            
        } else {
            rocco.move(speed: 0.2)

        }

        
        
        bg1.move(speed: 1)
        bg2.move(speed: 1)

        
        bg1.isOutOfScreen()
        bg2.isOutOfScreen()
        
        for trap in traps {
            trap.move(speed:5)
            if trap.isOutOfScreen() {
                trap.removeFromParent()
                traps.remove(element: trap)
                trapsCount-=1
                spawnEnemy()
            }
        }
        
        
       
        
        score += 1
        
        coffeSpawnCount += 1
        
        coffee.move(speed: 8)
        
        if coffeSpawnCount > 600 {
            spawnPowerup()
            coffeSpawnCount = 0
        }
        
        
        binSpawnCount += 1
        
        
        for bin in bins {
            bin.move(speed:5)
            if bin.isOutOfScreen() {
                bin.removeFromParent()
                bins.remove(element: bin)
            }
        }

        if binSpawnCount > 800 {
            spawnBin()
            binSpawnCount = 0
        }
        
        if snowCount > 30 {
            spawnSnow()
            snowCount = 0
        }


       
        
        updateInfo()
        
        spawnSnow()
        
        
  
    
    }
    

    func spawnPowerup(){
        
        print("spawnPowerup")
        
        coffee.removeFromParent()
        coffee = Powerup(imageNamed: "coffee")
        coffee.setup(withPosition: 0)
        addChild(coffee)
        

    }
    
    func spawnSnow(){
        
        let snow = Snow(circleOfRadius: 2)
        snow.setup()
        
        addChild(snow)
    }
    
     func spawnBin(){
        
        let bin = Enemy(imageNamed: "green_bins")
        bin.setupBin()
        bins.append(bin)
        addChild(bin)
         
    

     }
    
    func spawnEnemy(){
        
        if trapsCount > 2 {
            return
        }
        
        
        let trap1 = Enemy(imageNamed: "trap_1")
        for trap in traps {
            if (Int(trap1.position.x) - Int(trap.position.x)) < 20 {
                return
            }
        }
        trapsCount += 1

        traps.append(trap1)
        trap1.setup(withPosition: trap1.position.x)
        
        addChild(trap1)

    }
    
   
    func playSound(sound: String){
        

        let path = Bundle.main.path(forResource: sound, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func backgroundSound(sound: String){
        

        let path = Bundle.main.path(forResource: sound, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundAudioPlayer?.volume = 0.3
            backgroundAudioPlayer?.numberOfLoops = -1

            backgroundAudioPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
  
    
   
}
