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


class Apple {
    var id: Int = 0
    var title: String = ""
    var color: AppleColor = .green
    var state: AppleState = .onATree

    required init(_ id: Int, with title: String, color: AppleColor, state: AppleState) {
        self.id = id
        self.title = title
        self.color = color
        self.state = state
    }

    convenience init(_ id: Int, with title: String, color: String, state: String) {

        var colorRepresentation = AppleColor.green
        switch color {
        case "green":
            colorRepresentation = .green
        case "red":
            colorRepresentation = .red
        case "yellow":
            colorRepresentation = .yellow
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

        self.init(id, with: title, color: colorRepresentation, state: stateRepresentation)
    }
}
