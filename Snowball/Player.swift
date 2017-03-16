//
//  Player.swift
//  Snowball
//
//  Created by Caroline Davis on 23/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

struct ColliderType {
    
    static let Player: UInt32 = 0
    static let SnowBall: UInt32 = 1
    
}

class Player: SKSpriteNode {
    
    // all the stuff for the animation - to allow it to work
    private var textureAtlas = SKTextureAtlas()
    // the images inside the atlas
    private var playerAnimation = [SKTexture]()
    // the action that animates the player
    private var animatePlayerAction = SKAction()
    
    func initializePlayerAndAnimations() {
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        // puts images in array
        for i in 2...textureAtlas.textureNames.count {
            let name = "Run\(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        // animates the player
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        // physics body stuff
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5))
        self.physicsBody?.affectedByGravity = false
        // stops sprite rotating when it falls.
        self.physicsBody?.allowsRotation = false
        // stops the bouncing on the objects
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.SnowBall
        self.physicsBody?.contactTestBitMask = ColliderType.SnowBall

    }
    
    func animatePlayer(moveLeft: Bool) {
        // changes the sprite to go the other way when walking, fabs is absolute value
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else {
            self.xScale = fabs(self.xScale)
        }
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation(){
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Run1")
        self.size = (self.texture?.size())!
    }

    
    func movePlayer(moveLeft: Bool) {
        
        if moveLeft == true {
            self.position.x = self.position.x - 7
        } else {
            self.position.x = self.position.x + 7
        }
    }
    
  
}
