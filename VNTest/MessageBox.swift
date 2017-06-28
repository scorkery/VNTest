//
//  MessageBox.swift
//  VNTest
//
//  Created by Sean Corkery on 2/24/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation
import SpriteKit

class MessageBox: SKSpriteNode {

    private var textureAtlas = SKTextureAtlas()
    
    // change these defaults to suit your game
    private var fontName: String = "ChalkboardSE-Regular"
    private var fontSize: CGFloat = 11
    private var nameLabelFontSize: CGFloat = 16
    private var fontColor: UIColor = .white
    private var textSpeed: TimeInterval = 0.05
    
    func create(size: CGSize, position: CGPoint, textureAtlas: String, parentNode: SKNode) {
        
        self.size = size;
        self.position = position;
        self.textureAtlas = SKTextureAtlas(named: textureAtlas)
        self.zPosition = 100
        parentNode.addChild(self)
        
    }
    
    func setGraphic(named: String) {
        self.texture = textureAtlas.textureNamed(named)
    }
    
    private func textLineLabel(char: String, position: CGPoint) -> SKLabelNode {
        
        let theLabel = SKLabelNode(fontNamed: fontName)
        theLabel.fontSize = fontSize
        theLabel.fontColor = fontColor
        theLabel.position = position
        theLabel.horizontalAlignmentMode = .left
        theLabel.verticalAlignmentMode = .top
        theLabel.zPosition = 2
        theLabel.isHidden = false
        theLabel.text = char
        return theLabel
        
    }
    
    private func speakerLineLabel(char: String, position: CGPoint) -> SKLabelNode {
        
        let theLabel = SKLabelNode(fontNamed: fontName)
        theLabel.fontSize = nameLabelFontSize
        theLabel.fontColor = fontColor
        theLabel.position = position
        theLabel.horizontalAlignmentMode = .left
        theLabel.verticalAlignmentMode = .bottom
        theLabel.zPosition = 2
        theLabel.isHidden = false
        theLabel.text = char
        return theLabel
        
    }
    
    private func createLine(message: String) -> String {
        
        let wordArray = message.components(separatedBy: " ")
        var line: String = ""
        var done: Bool = false
        for word in wordArray {
            if !done {
                let testLabel: SKLabelNode = textLineLabel(char: line, position: CGPoint(x: 0, y: 0))
                testLabel.text = line + word
                if testLabel.frame.width <= (self.size.width - 20) {
                    line += word + " "
                }
                else {
                    done = true
                }
            }
        }
        
        return line
    }
    
    private func createLinesArray(message: String) -> [String] {
        
        var lines: [String] = []
        var nextLine: String = message
        
        var done = false
        
        while !done {
            let newLine = createLine(message: nextLine)
            
            if nextLine.characters.count > newLine.characters.count {
                nextLine = nextLine.substring(from: newLine.characters.endIndex)
            }
            else {
                done = true
            }
            lines.append(newLine)
        }
        
        return lines
    }
    
    private func setInitialBasePointForText() -> CGPoint {
        var basePoint = self.anchorPoint
        basePoint.x -= (self.size.width / 2) - 10
        basePoint.y += (self.size.height / 2) - 10
        return basePoint
    }
    
    func displayMessage(message: String) {
        
        self.removeAllChildren()
        
        var basePoint = setInitialBasePointForText()
        let lines: [String] = createLinesArray(message: message)
        var heightCount: CGFloat = 0
        var printSequence: [SKAction] = []
        
        for line in lines {
            if heightCount <= self.size.height - 20 {
                let displayLabel = textLineLabel(char: "", position: basePoint)
                let placeholderLabel = textLineLabel(char: line, position: basePoint)
                self.addChild(displayLabel)
                
                for char in line.characters {
                    let addChar = SKAction.run {
                        displayLabel.text?.append(char)
                    }
                    let wait = SKAction.wait(forDuration: textSpeed)
                    printSequence.append(addChar)
                    printSequence.append(wait)
                }
                
                heightCount += placeholderLabel.frame.height
                basePoint.y -= placeholderLabel.frame.height
            }
        }
        
        let printAll: SKAction = SKAction.sequence(printSequence)
        self.run(printAll, withKey: "displayMessage")
    }
    
    func displayPlainMessage(message: String) {
        
        self.removeAllChildren()
        
        let lines = createLinesArray(message: message)
        var basePoint = setInitialBasePointForText()
        var heightCount: CGFloat = 0
        
        for line in lines {
            if heightCount <= self.size.height - 20 {
                let displayLabel = textLineLabel(char: line, position: basePoint)
                self.addChild(displayLabel)
                heightCount += displayLabel.frame.height
                basePoint.y -= displayLabel.frame.height
            }
        }
        
    }
    
    func displaySpeakerNameField(speakerName: String) {
        let speakerLabel = speakerLineLabel(char: speakerName, position: CGPoint())
        let pos = CGPoint(x: self.anchorPoint.x - self.size.width / 2, y: self.anchorPoint.y + (self.size.height / 2) + 2)
        speakerLabel.position = pos
        self.addChild(speakerLabel)
    }
    
}
