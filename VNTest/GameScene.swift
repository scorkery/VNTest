//
//  GameScene.swift
//  VNTest
//
//  Created by Sean Corkery on 2/12/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var poopCounter: Int = 0
    let gameManager = GameManager()
    
    override func didMove(to view: SKView) {
        
        let center = CGPoint(x: (scene?.size.width)! / 2, y: (scene?.size.height)! / 2)
        let size: CGSize = (scene?.size)!
        
        gameManager.create(center: center, size: size)
        self.addChild(gameManager)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !gameManager.isAnimating() {
            gameManager.next()
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
