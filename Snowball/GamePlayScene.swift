//
//  GamePlayScene.swift
//  Snowball
//
//  Created by Caroline Davis on 22/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit


class GameplayScene: SKScene {

    var player: Player?
    var canMove = false
    var moveLeft = false
    var center: CGFloat?
    
    override func didMove(to view: SKView) {
       initialize()
            }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        moveBackgroundsAndGrounds()
       // createSnowballs()
    }
    
    func initialize() {
        
        createBg()
        createGrounds()
        createSnowTops()
        
        // to get the center of the screen
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as? Player!
        player?.initializePlayerAndAnimations()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // how to get the info where the user has touched
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center! {
                moveLeft = false
                player?.animatePlayer(moveLeft: false)
            } else {
                moveLeft = true
                player?.animatePlayer(moveLeft: true)
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func managePlayer(){
        if canMove == true {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    
    
    func createBg() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "GamePlay")
            bg.name = "GamePlay"
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            //  allows all backgrounds to come after the other on the horizontal scale
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            bg.zPosition = 0
            self.addChild(bg)
            
        }
    }
    
    func createGrounds() {
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = "Ground"
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            //  allows all backgrounds to come after the other on the horizontal scale
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 2))
            ground.zPosition = 3
            ground.yScale = 2
            self.addChild(ground)
            
        }
    }
    
    func createSnowTops() {
        for i in 0...2 {
            let snowTop = SKSpriteNode(imageNamed: "SnowTop")
            snowTop.name = "SnowTop"
            snowTop.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            //  allows all backgrounds to come after the other on the horizontal scale
            snowTop.position = CGPoint(x: CGFloat(i) * snowTop.size.width, y: (self.frame.size.height / 2.5))
            snowTop.zPosition = 4
           // snowTop.yScale = 1.5
            self.addChild(snowTop)
            
        }
    }

    
    
    func moveBackgroundsAndGrounds() {
        enumerateChildNodes(withName: "GamePlay", using: ({
            (node, error) in
            
            // can add this instead of doing "node" below
            // let bgNode = node as! SKSpriteNode
            
            // any code we put here will be executed for the specific child "BG"
            node.position.x -= 4
            
            // pushes background off screen then adds it to the end again
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
            
            
        }))
        
        enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            
            // any code we put here will be executed for the specific child "BG"
            node.position.x -= 1.5
            
            // pushes background off screen then adds it to the end again
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
            
            
        }))
        
        enumerateChildNodes(withName: "SnowTop", using: ({
            (node, error) in
            
            
            // any code we put here will be executed for the specific child "BG"
            node.position.x -= 2
            
            // pushes background off screen then adds it to the end again
            if node.position.x < -(self.frame.width) {
                node.position.x += self.frame.width * 3
            }
            
            
        }))
        
    }
    


}
