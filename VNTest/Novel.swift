//
//  Novel.swift
//  VNTest
//
//  Created by Sean Corkery on 2/26/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation

class Novel {
    
    private var messages: [Message] = []
    
    // Add characters to this array, specify name and filename of atlas containing images
    private var characters: [CharacterData] = [
        CharacterData(name: "Ui", atlasName: "ui.atlas")
    ]
    
    private let parser = Parser()
    
    init() {
        // change this string to match the filename of your initial script file
        parseMessageSet(filename: "Demo")
    }
    
    func parseMessageSet(messages: [String]) {
        self.messages = parser.createMessageArray(lines: messages)
    }
    
    func parseMessageSet(filename: String) {
        let rawMessages = parser.parseDialogFile(filename: filename)
        parseMessageSet(messages: rawMessages)
    }
    
    func parseNewInstruction(message: [String]) -> Message {
        return parser.parseLine(array: message)
    }
    
    func getNextMessage() -> Message {
        
        if messages.count > 0 {
            let nextMessage = messages[0]
            messages.remove(at: 0)
            return nextMessage
        }
        
        return Message(speakerName: "", messageBody: "")
        
    }
    
    func getCharacterData(name: String) -> CharacterData {
        
        for person in characters {
            if person.getName() == name { return person }
        }
        
        return CharacterData(name: "", atlasName: "")
    }
    
    func isCharacterAnimating() -> Bool {
        for c in characters {
            if c.isAnimating() { return true }
        }
        return false
    }
    
    func addCharacter(name: String, atlasName: String) {
        characters.append(CharacterData(name: name, atlasName: atlasName))
    }
    
}
