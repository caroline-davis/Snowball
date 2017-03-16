//
//  Snowballs.swift
//  Snowball
//
//  Created by Caroline Davis on 24/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class Snowballs {
    
    var lastSnowballPositionY = CGFloat()
    
    
    func snowShuffle(snowballArray: [SKSpriteNode]) -> [SKSpriteNode] {
        
        var snowballArray = [SKSpriteNode]()
        
        for index in 0..<snowballArray.count {
            let randomIndex = Int(arc4random_uniform(UInt32(snowballArray.count - index))) + index
            
            
            if index != randomIndex {
                // swaps indexes
                swap(&snowballArray[index], &snowballArray[randomIndex])
            }
        }
        
        return snowballArray
    
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        // arc4random returns a number between 0 to (2**32)-1
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
    func createSnow() -> [SKSpriteNode] {
        
        var snowballs = [SKSpriteNode]()
        
        // looping twice
        for index in 0 ..< 2 {
            let snowball1 = SKSpriteNode(imageNamed: "Snowball1")
            snowball1.name = "1"
            let snowball2 = SKSpriteNode(imageNamed: "Snowball2")
            snowball2.name = "2"
            let snowball3 = SKSpriteNode(imageNamed: "Snowball3")
            snowball3.name = "3"
           
            snowball1.xScale = 0.9
            snowball1.yScale = 0.9
            
            snowball2.xScale = 0.9
            snowball2.yScale = 0.9
            
            snowball3.xScale = 0.9
            snowball3.yScale = 0.9
            
            
            // add physics body to the clouds
            snowball1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: snowball1.size.width - 6, height: snowball1.size.height - 6))
            snowball1.physicsBody?.affectedByGravity = true
            snowball1.physicsBody?.restitution = 0
            snowball1.physicsBody?.categoryBitMask = ColliderType.SnowBall
            snowball1.physicsBody?.collisionBitMask = ColliderType.Player
            
            snowball2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: snowball2.size.width - 6, height: snowball2.size.height - 7))
            snowball2.physicsBody?.affectedByGravity = true
            snowball2.physicsBody?.restitution = 0
            snowball2.physicsBody?.categoryBitMask = ColliderType.SnowBall
            snowball2.physicsBody?.collisionBitMask = ColliderType.Player
            
            snowball3.physicsBody = SKPhysicsBody(rectangleOf: snowball3.size)
            snowball3.physicsBody?.affectedByGravity = true
            snowball3.physicsBody?.categoryBitMask = ColliderType.SnowBall
            snowball3.physicsBody?.collisionBitMask = ColliderType.Player
            
            snowballs.append(snowball1)
            snowballs.append(snowball2)
            snowballs.append(snowball3)
            
        }
        
        snowballs = snowShuffle(snowballArray: snowballs)
        
        return snowballs
    }
    
    // creates the distance between clouds on the Y axis in the correct scene.
    func arrangeCloudsInScene(scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, initialSnowballs: Bool) {
        
        var snowballs = createSnow()
        
    
        
        // current y position of cloud
        var positionY = CGFloat()
        
        if initialSnowballs {
            positionY = center - 100
        } else {
            positionY = lastSnowballPositionY
        }
        
        var random = 0
        
        for i in 0...snowballs.count - 1 {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 90 , secondNum: maxX)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX)
                random = 0
            }
            
            snowballs[i].position = CGPoint(x: randomX, y: positionY)
            snowballs[i].zPosition = 3
            
            scene.addChild(snowballs[i])
            positionY -= distanceBetweenClouds
            lastSnowballPositionY = positionY
        }

    }

}
