//
//  ValidInstructions.swift
//  VNTest
//
//  Created by Sean Corkery on 3/22/17.
//  Copyright © 2017 Sean Corkery. All rights reserved.
//

import Foundation

enum ValidInstructions: String {
    
    case background = "background"
    case enter = "enter"
    case exit = "exit"
    case setVar = "setVar"
    case add = "add"
    case subtract = "subtract"
    case testVar = "testVar"
    case printVar = "printVar"
    case jump = "jump"
    case none
    
    func isValid(inst: String) -> Bool {
        switch (inst) {
        case ValidInstructions.background.rawValue,
             ValidInstructions.enter.rawValue,
             ValidInstructions.exit.rawValue,
             ValidInstructions.setVar.rawValue,
             ValidInstructions.add.rawValue,
             ValidInstructions.subtract.rawValue,
             ValidInstructions.testVar.rawValue,
             ValidInstructions.printVar.rawValue,
             ValidInstructions.jump.rawValue:
            return true

        default:
            return false
        }
    }
}
