//
//  ApplesStorage.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by user on 19/09/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import Promises

enum AppleFilter : Int {
    case all = 0
    case needToEat
    case eaten
    case onATree
}

class ApplesStorage {
    
    var filter: AppleFilter = .all {
        didSet {
            fetchFromDbUsingFilter()
        }
    }
    
    private(set) var applesCollection = ApplesCollection()
    
    private var networkStorage: NetworkStorage
    private var dbStorage: DBStorage
    private var fetchingFromNetwork = false {
        didSet {
            assert(Thread.isMainThread)
        }
    }
    
    private lazy var applesStorageSerialQueue: DispatchQueue = {
        return DispatchQueue(label: "com.someapp.applesStorage")
    }()
    
    required init(networkStorage: NetworkStorage, dbStorage: DBStorage) {
        self.networkStorage = networkStorage
        self.dbStorage = dbStorage
    }
    
    func fetchApples() {
        fetchFromNetwork()
    }
    
    private func fetchFromDbUsingFilter() {
        let appleState = appleStateForFetch()
        dbStorage.fetchApplesFromDb(by: appleState).then { [weak self] (apples) in
            
            assert(Thread.isMainThread)
            
            guard let strongSelf = self else {
                return
            }
            
            print("Apples fetched from DB\n")
            strongSelf.applesCollection.update(apples: apples)
        }
    }
    
    private func fetchFromNetwork() {
        if fetchingFromNetwork {
            return
        }
        fetchingFromNetwork = true
        
        let fetchingPromise = Promise<Void>(on: applesStorageSerialQueue) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.fetchWithPromise()
        }
            
        fetchingPromise.catch { (error) in
            print(error)
        }
    }
    
    private func fetchWithPromise() {
        
        assert(!Thread.isMainThread)
        
        networkStorage.fetchFromNetwork().then(on: applesStorageSerialQueue, { [weak self] (jsonApples) in
            return self?.dbStorage.syncApples(with: jsonApples).then { [weak self] in
                
                assert(Thread.isMainThread)
                
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.fetchFromDbUsingFilter()
                strongSelf.fetchingFromNetwork = false
            }
        })
    }
    
    private func appleStateForFetch() -> AppleState? {
        switch filter {
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
