//
//  NetworkStorage.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 19/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import Promises

class NetworkStorage {
    
    private let applesCreator = ApplesCreator()
    private lazy var networkStorageSerialQueue: DispatchQueue = {
        return DispatchQueue(label: "com.someapp.networkStorage")
    }()
    
    func fetchFromNetwork() -> Promise<[JsonApple]> {
        return Promise<[JsonApple]>(on: networkStorageSerialQueue) { [weak self] in
            
            guard let strongSelf = self else {
                fatalError()
            }
            
            let delay = UInt32(randomInt(min: 1, max: 3))
            print("Network fetching delay: \(delay)")
            sleep(delay)
            
            let added = randomInt(min: 0, max: 4)
            let edited = randomInt(min: 0, max: 5)
            let removed = randomInt(min: 0, max: 3)
            
            print("Added: \(added), edited: \(edited), removed: \(removed)")
            
            return strongSelf.applesCreator.getApples(editCount: edited, createCount: added, removeCount: removed)
        }
    }
}
