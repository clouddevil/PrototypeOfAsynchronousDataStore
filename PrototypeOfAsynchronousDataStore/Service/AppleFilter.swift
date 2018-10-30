//
//  AppleFilter.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 30/10/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

enum AppleFilter: Int {
    case all = 0
    case needToEat
    case eaten
    case onATree
}

extension AppleFilter {
    func dbFilterState() -> AppleState? {
        switch self {
        case .eaten:
            return .eaten
        case .needToEat:
            return .needToEat
        case .onATree:
            return .onATree
        default:
            return nil
        }
    }
}
