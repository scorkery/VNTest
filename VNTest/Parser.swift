//
//  Parser.swift
//  VNTest
//
//  Created by Sean Corkery on 3/22/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation

class Parser {
    
    // change these defaults to suit your game
    private let document: String = ""
    private let separatorChar: String = "|"
    private let narratorTag: String = "nar"
    
    func parseDialogFile(filename: String) -> [String] {
        
        let lines: [String]
        
        do {
            let filepath = Bundle.main.path(forResource: filename, ofType: "")
            if filepath != nil {
                let contents = try String(contentsOfFile: filepath!)
                lines = contents.components(separatedBy: "\n")
            }
            else {
                print("Nil filepath")
                lines = []
            }
        }
        catch {
            lines = []
        }
        
        return lines
        
    }
    
    func createMessageArray(lines: [String]) -> [Message] {
        
        var messages: [Message] = []
        for line in lines {
            let msg = parseLine(mes: line)
            if let inst = msg as? Instruction {
                messages.append(inst)
            }
            else {
                messages.append(msg)
            }
        }
        return messages
        
    }
    
    func parseLine(mes: String) -> Message {
        
        var wordArray = mes.components(separatedBy: separatorChar)
        
        if wordArray.count > 0 {
            // check if argument 0 is a valid instruction
            let validInstructions:ValidInstructions = .none
            let isValid = validInstructions.isValid(inst: wordArray[0])
            
            // if it is, put the arguments into an array and return an instruction
            if isValid {
                var argumentsArray: [String] = []
                for index in 1...wordArray.count - 1 {
                    argumentsArray.append(wordArray[index])
                }
                return Instruction(type: wordArray[0], data: argumentsArray)
            }
            // otherwise we assume it's a message (narrative/spoken dialog)
            else {
                // a message string will have exactly 2 components
                if wordArray.count == 2 {
                    if (wordArray[0] == narratorTag) { wordArray[0] = "" }
                    return Message(speakerName: wordArray[0], messageBody: wordArray[1])
                }
            }
        }
        
        // if line supplied does not conform to definition of instruction or message, return blank message
        return Message(speakerName: "", messageBody: "")
        
    }
    
    func parseLine(array: [String]) -> Message {
        var newLine: String = ""
        for word in array {
            newLine.append(word + "|")
        }
        
        newLine.remove(at: newLine.index(before: newLine.endIndex))
        
        return parseLine(mes: newLine)
    }
    
}
