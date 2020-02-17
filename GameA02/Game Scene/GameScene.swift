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
    public var sceneMenager : SceneManager?

    
    
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
    var trapCount = 0

    
    var bestScore  = Info()

    var distance  = Info()
    var score = 0
    var life = 0
    var maxLife = 5

    
    var stop = false
    
    var restart = Button()
    var exit = Button()

    
    var pause = Button()

    
    var viewWidth = CGFloat()
    var viewHeight = CGFloat()
    
    var deltaVelocity = 1.0

    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.62)

     
        
        viewWidth = UIScreen.main.bounds.width
        viewHeight = UIScreen.main.bounds.height

        
        start()
        
        
       

  
    }
    
    func debug(){
        
        self.view?.showsFPS = true
        self.view?.showsNodeCount = true
        self.view?.showsPhysics = true
        
        

    }
    
    func start(){
        
        
        
        coffeSpawnCount = 0
        binSpawnCount = 0
        snowCount = 0
        trapCount = 0
        score = 0

        
        backgroundSound(sound: Constants().gameMusicBackground)


        restart.removeFromParent()
        stop = false
        life = maxLife
        
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
        restart.setup(width: 150, height: 60, name: "restart")
        
        exit = Button(imageNamed: "exit")
        exit.setup(width: 150, height: 60, name: "exit")
        exit.position.y =  exit.position.y  - 60
        
        
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
        backgroundSound(sound: Constants().gameMusicBackground)

        stop = true
        rocco.dead()
        
        let best = Scoreboard().getBest()

        if score > best {
            Scoreboard().saveBest(score: score)
        }
        
        pause.removeFromParent()
        
        
        restart.removeFromParent()
        addChild(restart)

        exit.removeFromParent()
        addChild(exit)
        
    }
    
    func updateInfo(){
        
        var l = ""
        
        
        
        if life > 0 {
            for _ in 1...life {
                l = l + "❤️"
                
            }

        }
        
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
        

        
        let nodeCoffee = checkNodeName(nodeA, nodeB: nodeB, name: Constants().nodePoweup) as? Powerup
        let nodePlayer = checkNodeName(nodeA, nodeB: nodeB, name: Constants().nodePlayer) as? Player
        let nodeTrap = checkNodeName(nodeA, nodeB: nodeB, name: Constants().nodeEnemy) as? Enemy

        if (nodeCoffee != nil), (nodePlayer != nil) {
            if life < maxLife { life += 1}
            updateInfo()
            nodeCoffee?.removeFromParent()
            coffeSpawnCount = 0
            return
        }
        
        
        if (nodeTrap != nil), (nodePlayer != nil) {
            nodeTrap?.trigged()
            if nodePlayer?.flagHitted == true {return}
            playSound(sound:  Constants().soundHit)
            life -= 1
            if life < 1 {
                nodeTrap?.removeFromParent()
                playSound(sound: Constants().soundDead)
                updateInfo()
                
                finish()
            }else {
                rocco.hitted()
                
            }


            return
        }
        
        
    }
    
    

   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if checkTouch(touch: touches.first!, node: "pause") {
            pauseGame()
            return

        }
        if stop  {
            
            if checkTouch(touch: touches.first!, node: "exit") {
                sceneMenager?.backToMenu()
                return
                
            }
            
            if checkTouch(touch: touches.first!, node: "restart") {
                restartGame()
                return
                
            }

            
            return
            
        }
        if rocco.flagJump == false {
            playSound(sound: Constants().soundJump)
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
        
        if rocco.position.x < -50 {
            rocco.move(speed: 0.2)

        }
        
        
        bg1.move(speed: Double(1 * deltaVelocity))
        bg2.move(speed:Double(1 * deltaVelocity))

        
        bg1.isOutOfScreen()
        bg2.isOutOfScreen()
        
        
        trapCount   += 1
        
        for trap in traps {
            trap.move(speed:Double(5 * deltaVelocity))
            if trap.isOutOfScreen() {
                trap.removeFromParent()
                traps.remove(element: trap)
                trapsCount-=1
            }
        }
        
        
       
        
        score += 1
        
        deltaVelocity = Double(deltaVelocity + 0.0001)
        
        coffeSpawnCount += 1
        
        coffee.move(speed: Double(6 * deltaVelocity))
        
        if coffeSpawnCount > 600 {
            spawnPowerup()
            coffeSpawnCount = 0
        }
        
        
        binSpawnCount += 1
        
        
        for bin in bins {
            bin.move(speed:Double(5 * deltaVelocity))
            if bin.isOutOfScreen() {
                bin.removeFromParent()
                bins.remove(element: bin)
            }
        }

        if binSpawnCount > 400 {
            spawnBin()
            binSpawnCount = 0
        }
        
        if snowCount > 30 {
            spawnSnow()
            snowCount = 0
        }
        
        
        if trapCount > 100 {
            spawnEnemy()
             trapCount = 0
        }


       
        
        updateInfo()
        
        spawnSnow()
        
        
  
    
    }
    

    func spawnPowerup(){
        
        
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
        
        if trapsCount > 10 {
            return
        }
        
        let trap1 = Enemy(imageNamed: "trap_1")

        trap1.setup(withPosition: trap1.position.x)
        
        for trap in traps {
            if (Int(trap1.position.x) - Int(trap.position.x)) < 20 {
                return
            }
        }
        
        
        trapsCount += 1

        traps.append(trap1)
        
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


