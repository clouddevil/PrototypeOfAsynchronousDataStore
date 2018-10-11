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
            
            let delay = UInt32.random(in: 1..<3)
            print("Network fetching delay: \(delay)")
            sleep(delay)
            
            let added = Int.random(in: 0..<4)
            let edited = Int.random(in: 0..<5)
            let removed = Int.random(in: 0..<3)
            
            print("Added: \(added), edited: \(edited), removed: \(removed)")
            
            return strongSelf.applesCreator.getApples(editCount: edited, createCount: added, removeCount: removed)
        }
    }
}
