//
//  GameScreen.swift
//  VNTest
//
//  Created by Sean Corkery on 2/25/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager: SKNode {
    
    private let bkd = Background()
    private let msg = MessageBox()
    private let novel = Novel()
    
    // change defaults to suit your game
    private let backgroundsAtlasName = "backgrounds.atlas"
    private let defaultBackground = "sunset.png"
    private let interfaceAtlasName = "interface.atlas"
    private let textboxGraphic = "textbox.png"
    
    private var currentMessage = Message(speakerName: "", messageBody: "")
    
    func create(center: CGPoint, size: CGSize) {
        
        // set up background, change name of atlas and default texture to suit your game
        // a default background must be loaded before the message box is created in order
        // to size the message box correctly, alternatively box can be resized manually using resizeMesageBox
        bkd.create(atlasNamed: backgroundsAtlasName, screenCenter: center, screenSize: size, parentNode: self)
        bkd.change(to: defaultBackground)
        
        // set background, change atlas and box graphic names, size/pos details to suit your game
        let bkdSize = bkd.getBackgroundSize()
        let msgSize = CGSize(width: bkdSize.width - 20, height: (bkdSize.height / 4) - 20)
        let msgPos = CGPoint(x: bkd.position.x, y: bkd.size.height / 8)
        msg.create(size: msgSize, position: msgPos, textureAtlas: interfaceAtlasName, parentNode: self)
        msg.setGraphic(named: textboxGraphic)
        
    }
    
    func next() {
        
        if msg.action(forKey: "displayMessage") != nil {
            msg.removeAction(forKey: "displayMessage")
            displayMessage(message: currentMessage, plain: true)
        }
        else {
            let nextMessage = novel.getNextMessage()
            
            if let nextInstruction: Instruction = nextMessage as? Instruction {
                executeInstruction(instruction: nextInstruction)
            }
            else {
                displayMessage(message: nextMessage)
            }
            
            currentMessage = nextMessage
        }
        
    }
    
    func isAnimating() -> Bool {
        return novel.isCharacterAnimating()
    }
    
    private func changeBackground(named: String, effect: String = "", rate: String = "") {
        
        switch effect {
        case "fade":
            let newBkd = SKSpriteNode(imageNamed: named)
            newBkd.size = bkd.getBackgroundSize()
            newBkd.position = bkd.position
            newBkd.alpha = 0
            var fadeAction: SKAction
            if let numRate = Double(rate) { fadeAction = SKAction.fadeIn(withDuration: numRate) }
            else { fadeAction = SKAction.fadeIn(withDuration: 2) }
            let removeAction = SKAction.run {
                self.bkd.change(to: named)
                self.removeChildren(in: [newBkd])
            }
            let sequence = SKAction.sequence([fadeAction, removeAction])
            self.addChild(newBkd)
            newBkd.run(sequence)
            break
            
        default:
            self.bkd.change(to: named)
            break
        }
        
    }
    
    private func enter(who: String, image: String = "", whereAt: String = "", howBig: String = "", effect: String = "") {
        
        let theCharacter = novel.getCharacterData(name: who)
        if image != "" { theCharacter.setImage(name: image) }
        if whereAt != "" { theCharacter.setPosition(position: CGPointFromString(whereAt)) }
        if howBig != "" { theCharacter.setSize(size: CGSizeFromString(howBig)) }
        
        theCharacter.sprite.draw(parentNode: self, effect: effect)
        
    }
    
    private func exit(who: String, effect: String = "") {
        
        let theCharacter = novel.getCharacterData(name: who)
        theCharacter.sprite.exit(parentNode: self, effect: effect)
        
    }
    
    private func setVar(forWho: String, name: String, value: String) {
        let who = novel.getCharacterData(name: forWho)
        who.setVar(name: name, value: value)
    }
    
    private func getVar(forWho: String, name: String) -> String {
        let who = novel.getCharacterData(name: forWho)
        return "\(who.getVar(name: name))"
    }
    
    private func add(forWho: String, name: String, amount: String) {
        let who = novel.getCharacterData(name: forWho)
        if let num1 = Int(amount) {
            if let num2 = Int(who.getVar(name: name)) {
                let sum = num1 + num2
                who.setVar(name: name, value: "\(sum)")
            }
            else { print("Unable to cast data to number.") }
        }
        else { print("Unable to cast argument to number.") }
    }
    
    private func subtract(forWho: String, name: String, amount: String) {
        let who = novel.getCharacterData(name: forWho)
        if let num2 = Int(amount) {
            if let num1 = Int(who.getVar(name: name)) {
                let dif = num1 - num2
                who.setVar(name: name, value: "\(dif)")
            }
            else { print("Unable to cast data to number.") }
        }
        else { print("Unable to cast argument to number.") }
    }
    
    private func testVar(forWho: String, name: String, condition: String) -> Bool {
        let who = novel.getCharacterData(name: forWho)
        return who.testVar(name: name, condition: condition)
    }
    
    private func setMessageGraphic(named: String) {
        self.msg.setGraphic(named: named)
    }
    
    private func resizeMessageBox(siz: CGSize) {
        self.msg.size = siz
    }
    
    private func repositionMessageBox(pos: CGPoint) {
        self.msg.position = pos
    }
    
    private func executeInstruction(instruction: Instruction) {
        
        let type = instruction.getType()
        let data = instruction.getData()
        
        switch type {
        case ValidInstructions.background.rawValue:
            if data.count == 1 { changeBackground(named: data[0]) }
            else if data.count == 2 { changeBackground(named: data[0], effect: data[1]) }
            else if data.count == 3 { changeBackground(named: data[0], effect: data[1], rate: data[2]) }
            break
            
        case ValidInstructions.enter.rawValue:
            if data.count == 5 {
                enter(who: data[0], image: data[1], whereAt: data[2], howBig: data[3], effect: data[4])
            }
            break
            
        case ValidInstructions.exit.rawValue:
            if data.count == 1 { exit(who: data[0]) }
            else if data.count == 2 { exit(who: data[0], effect: data[1]) }
            break
            
        case ValidInstructions.setVar.rawValue:
            if data.count == 3 {
                setVar(forWho: data[0], name: data[1], value: data[2])
                print("set variable: " + data[0] + ":" + data[1] + ":" + data[2])
            }
            break
            
        case ValidInstructions.add.rawValue:
            if data.count == 3 {
                add(forWho: data[0], name: data[1], amount: data[2])
                print("add: " + data[0] + ":" + data[1] + ":" + data[2])
            }
            break
            
        case ValidInstructions.subtract.rawValue:
            if data.count == 3 {
                subtract(forWho: data[0], name: data[1], amount: data[2])
                print("subtract: " + data[0] + ":" + data[1] + ":" + data[2])
            }
            break
            
        case ValidInstructions.printVar.rawValue:
            if data.count == 2 {
                print(getVar(forWho: data[0], name: data[1]))
            }
            break
            
        case ValidInstructions.testVar.rawValue:
            if data.count >= 4 {
                print("test variable:" + data[0] + ":" + data[1] + " for condition: " + data[2])
                let test: Bool = testVar(forWho: data[0], name: data[1], condition: data[2])
                if test {
                    print("true.")
                    if data.count > 4 {
                        var newInstComponents: [String] = []
                        for i in 3...data.count - 1 {
                            newInstComponents.append(data[i])
                        }
                        let newMsg = novel.parseNewInstruction(message: newInstComponents)
                        if let newInst = newMsg as? Instruction {
                            executeInstruction(instruction: newInst)
                        }
                        else {
                            displayMessage(message: newMsg)
                        }
                    }
                }
                else {
                    print("false.")
                }
            }
            break
            
        case ValidInstructions.jump.rawValue:
            if data.count == 1 { novel.parseMessageSet(filename: data[0]) }
            break
            
        default:
            break
        }
        
    }
    
    private func displayMessage(message: Message, plain: Bool = false) {
        
        if plain { msg.displayPlainMessage(message: message.getMessageBody()) }
        else { msg.displayMessage(message: message.getMessageBody()) }
            
        if message.getSpeakerName() != "" {
            msg.displaySpeakerNameField(speakerName: message.getSpeakerName())
        }
    }
}
