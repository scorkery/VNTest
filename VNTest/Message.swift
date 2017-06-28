//
//  Message.swift
//  VNTest
//
//  Created by Sean Corkery on 3/5/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation

class Message {
    
    private let speakerName: String
    private let messageBody: String
    
    init(speakerName: String, messageBody: String) {
        self.messageBody = messageBody
        self.speakerName = speakerName
    }
    
    func getSpeakerName() -> String {
        return speakerName
    }
    
    func getMessageBody() -> String {
        return messageBody
    }
    
}

class Instruction: Message {
    
    private let type: String
    private var data: [String]
    
    init(type: String, data: [String] = []) {
        self.type = type
        self.data = data
        super.init(speakerName: "", messageBody: "")
    }
    
    func getType() -> String {
        return type
    }
    
    func getData() -> [String] {
        return data
    }
    
}
