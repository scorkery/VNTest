//
//  Background.swift
//  VNTest
//
//  Created by Sean Corkery on 2/12/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    
    private var textureAtlas: SKTextureAtlas = SKTextureAtlas()
    private var screenCenterPoint: CGPoint = CGPoint() // screen center of device
    private var screenSize: CGSize = CGSize() // screen size of device
    
    func create(atlasNamed: String, screenCenter: CGPoint, screenSize: CGSize, parentNode: SKNode) {
        
        self.textureAtlas = SKTextureAtlas(named: atlasNamed)
        self.screenCenterPoint = screenCenter
        self.screenSize = screenSize
        self.zPosition = 0
        
        parentNode.addChild(self)
        
    }
    
    private func centerAndScale() {
        
        let oldSize: CGSize = (self.texture?.size())!
        let aspectRatio: CGFloat = oldSize.height / oldSize.width
        let adjustedHeight = self.screenSize.height
        let adjustedWidth = adjustedHeight / aspectRatio
        let newSize = CGSize(width: adjustedWidth, height: adjustedHeight)
        
        self.size = newSize
        self.position = self.screenCenterPoint
        
    }
    
    func change(to: String) {
        self.texture = self.textureAtlas.textureNamed(to)
        self.centerAndScale()
    }
    
    func getBackgroundSize() -> CGSize {
        return self.size
    }
    
}


