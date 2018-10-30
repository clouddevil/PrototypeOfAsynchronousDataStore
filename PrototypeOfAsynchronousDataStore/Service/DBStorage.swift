//
//  DBStorage.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 19/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import Promises

fileprivate let kInitialApplesDict: Dictionary<Int, Apple> = [
    0: Apple(with: "Антоновка", color: .green, state: .onATree),
    1: Apple(with: "Грушовка", color: .yellow, state: .needToEat)
]


class DBStorage {
    
    private var apples: Dictionary<Int, Apple> = kInitialApplesDict
    private lazy var dbStorageSerialQueue: DispatchQueue = {
        return DispatchQueue(label: "com.someapp.dbStorage")
    }()
    
    func fetchApplesFromDb(by state: AppleState? = nil) -> Promise<[Apple]> {
        return Promise<[Apple]>(on: dbStorageSerialQueue) { [weak self] in
            
            guard let strongSelf = self else {
                fatalError()
            }
            
            sleepThread(time: 1)
            
            print("Fetching from db using filter: \(state?.rawValue ?? "Все")")
            
            var outputApples = [Apple]()
            strongSelf.apples.forEach({ (key, val) in
                if state == nil || val.state == state {
                    outputApples.append(val)
                }
            })
            
            return outputApples
        }
    }
    
    func syncApples(with jsonApples: [JsonApple]) -> Promise<Void> {
        assert(!Thread.isMainThread)
        
        return Promise<Void>(on: dbStorageSerialQueue) { [weak self] in
            
            guard let strongSelf = self else {
                fatalError()
            }
            
            sleepThread(time: 1)
            
            //print("DB sync delay: \(delay)")
            
            strongSelf.apples = [Int:Apple]()
            for apple in jsonApples {
                strongSelf.apples[apple.id] = Apple(with: apple.title,
                                                    color: apple.color,
                                                    state: apple.state)
            }
        }
    }
}
