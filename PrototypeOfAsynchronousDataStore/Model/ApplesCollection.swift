//
//  ApplesCollection.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 20/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

typealias VoidBlock = () -> Void

class ApplesCollection {
    
    private(set) var apples = Array<Apple>()
    private var subscribers = Dictionary<AnyHashable, VoidBlock>()
    
    func subscribeOnChanges(obj: AnyHashable, block: @escaping VoidBlock) {
        subscribers[obj] = block
    }
    
    func unsubscribe(obj: AnyHashable) {
        subscribers.removeValue(forKey: obj)
    }
    
    func update(apples: [Apple]) {
        self.apples = apples
        notifySubscribersOnChanges()
    }
    
    private func notifySubscribersOnChanges() {
        subscribers.forEach { (_, block) in
            block()
        }
    }
}
