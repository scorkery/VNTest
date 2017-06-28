//
//  CharacterData.swift
//  VNTest
//
//  Created by Sean Corkery on 3/6/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterData {
    
    private let name: String
    private let atlasName: String
    private var data: [String:String] = [:]
    var sprite: CharacterPortrait
    
    init(name: String, atlasName: String) {
        self.name = name
        self.atlasName = atlasName
        self.sprite = CharacterPortrait()
        self.sprite.setTextureAtlas(atlasName: atlasName)
    }
    
    func setSize(size: CGSize) {
        self.sprite.size = size
    }
    
    func setPosition(position: CGPoint) {
        self.sprite.position = position
    }
    
    func setImage(name: String) {
        self.sprite.setImage(name: name)
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getAtlasName() -> String {
        return self.atlasName
    }
    
    func getSize() -> CGSize {
        return self.sprite.size
    }
    
    func getPosition() -> CGPoint {
        return self.sprite.position
    }
    
    func isAnimating() -> Bool {
        return (self.sprite.action(forKey: "animating") != nil)
    }
    
    func setVar(name: String, value: String) {
        data[name] = value;
    }
    
    func getVar(name: String) -> String {
        return data[name] ?? "Error: Data not found"
    }
    
    func testVar(name: String, condition: String) -> Bool {
        return data[name] == condition
    }
    
}







