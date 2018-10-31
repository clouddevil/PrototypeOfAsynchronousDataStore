//
// Created by Eugene Kalinin on 30/10/2018.
// Copyright (c) 2018 user. All rights reserved.
//

import Foundation
import Promises

typealias VoidBlock = () -> Void


class ApplesService {

    private var filter: AppleFilter = .all
    private(set) var apples = Array<Apple>()
    private var subscribers = Dictionary<AnyHashable, VoidBlock>()

    private var dbStorage: DBStorage
    private var networkStorage: NetworkStorage

    required init(networkStorage: NetworkStorage, dbStorage: DBStorage) {
        self.dbStorage = dbStorage
        self.networkStorage = networkStorage
    }

    private func update(_ apples: [Apple]) {
        self.apples = apples
        notifySubscribersOnChanges()
    }

    private func notifySubscribersOnChanges() {
        subscribers.forEach { (_, block) in
            block()
        }
    }

    private func fetchDbApples() {
        self.dbStorage.fetchApplesFromDb(by: filter.dbFilterState()).then { (_ fetchedApples: [Apple]) in
            self.update(fetchedApples)
        }
    }

    func fetchApples() {
        let jsonApplesPromise = self.networkStorage.fetchFromNetwork()
        let savedApplesPromise = jsonApplesPromise.then({ [weak self] (_ jsonApples: [JsonApple]) in
                return self?.dbStorage.syncApples(with: jsonApples)
            })
        savedApplesPromise.then({ [weak self] (_) -> Void in
                self?.fetchDbApples()
            })
    }

    func fetchDbApplesWithFilter(_ filter: AppleFilter) {
        self.filter = filter
        fetchDbApples()
    }

    func eatApple(_ appleId: Int) {
        self.networkStorage.eatNetworkApple(appleId).then({ [weak self]  (_ jsonApples: [JsonApple]) -> Promise<Void> in
            guard let `self` = self else {
                //throw Error("")
                throw NSError(domain: "", code: 0, userInfo: nil)
                //reject()
            }
            let allPromises = all(jsonApples.map({ (_ jsonApple: JsonApple) in
                return self.dbStorage.updateApple(with: jsonApple)
            }))

            return allPromises.then({ _ -> Void in
                return ()
            })
           
        }).then({ [weak self] (_) in
            self?.fetchDbApples()
        })
        
        
    }

    func subscribeOnChanges(obj: AnyHashable, block: @escaping VoidBlock) {
        subscribers[obj] = block
    }

    func unsubscribe(obj: AnyHashable) {
        subscribers.removeValue(forKey: obj)
    }

}
