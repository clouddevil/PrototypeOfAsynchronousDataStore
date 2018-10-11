//
//  Apple.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 19/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

enum AppleColor {
    case green
    case red
    case yellow
}

extension AppleColor {
    func toUIColor() -> UIColor {
        switch self {
        case .green:
            return UIColor.green.withAlphaComponent(0.5)
        case .red:
            return UIColor.red.withAlphaComponent(0.5)
        case .yellow:
            return UIColor.yellow.withAlphaComponent(0.5)
        }
    }
}

enum AppleState: String {
    case onATree = "На дереве"
    case needToEat = "Нужно съесть"
    case eaten = "Съедено"
}

class Apple {
    var title: String = ""
    var color: AppleColor = .green
    var state: AppleState = .onATree
    
    required init(with title: String, color: AppleColor, state: AppleState) {
        self.title = title
        self.color = color
        self.state = state
    }
    
    convenience init(with title: String, color: String, state: String) {
        
        var colorRepresentation = AppleColor.green
        switch color {
        case "green":
            colorRepresentation = .green
            break
        case "red":
            colorRepresentation = .red
            break
        case "yellow":
            colorRepresentation = .yellow
            break
        default:
            break
        }
        
        var stateRepresentation = AppleState.eaten
        switch state {
        case "eaten":
            stateRepresentation = .eaten
        case "needToEat":
            stateRepresentation = .needToEat
        case "onATree":
            stateRepresentation = .onATree
        default:
            break
        }
        
        self.init(with: title, color: colorRepresentation, state: stateRepresentation)
    }
}
