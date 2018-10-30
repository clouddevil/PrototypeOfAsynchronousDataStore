//
//  JsonApple.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 05/10/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class JsonApple {
    var id: Int
    var title: String
    var color: String
    var state: String

    required init(appleId: Int, title: String, color: String, state: String) {
        self.id = appleId
        self.title = title
        self.color = color
        self.state = state
    }
}
