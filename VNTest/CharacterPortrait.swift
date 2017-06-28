//
//  CharacterPortrait.swift
//  VNTest
//
//  Created by Sean Corkery on 3/6/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterPortrait: SKSpriteNode {
    
    private var textureAtlas: SKTextureAtlas = SKTextureAtlas()
    
    func setTextureAtlas(atlasName: String) {
        self.textureAtlas = SKTextureAtlas(named: atlasName)
    }
    
    func setImage(name: String) {
        self.texture = textureAtlas.textureNamed(name)
    }
    
    func draw(parentNode: SKNode, effect: String = "") {
        
        self.zPosition = 1
        
        switch effect {
        case "fade":
            if self.action(forKey: "animating") == nil {
                self.alpha = 0
                let fadeAction = SKAction.fadeIn(withDuration: 1)
                parentNode.addChild(self)
                self.run(fadeAction, withKey: "animating")
            }
            break
            
        default:
            parentNode.addChild(self)
            break
        }
        
    }
    
    func exit(parentNode: SKNode, effect: String = "") {
        
        switch effect {
        case "fade":
            if self.action(forKey: "animating") == nil {
                let fadeAction = SKAction.fadeOut(withDuration: 1)
                let remove = SKAction.run {
                    parentNode.removeChildren(in: [self])
                }
                self.run(SKAction.sequence([fadeAction, remove]), withKey: "animating")
            }
            
            break
            
        default:
            parentNode.removeChildren(in: [self])
            break
        }
        
    }
    
}
