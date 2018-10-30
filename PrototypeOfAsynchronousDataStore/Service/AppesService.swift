//
// Created by Eugene Kalinin on 30/10/2018.
// Copyright (c) 2018 user. All rights reserved.
//

import Foundation

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
        self.networkStorage.fetchFromNetwork().then({ (_ jsonApples: [JsonApple]) -> Void in
            self.dbStorage.syncApples(with: jsonApples).then({
                self.fetchDbApples()
            })
        })
    }

    func fetchDbApplesWithFilter(_ filter: AppleFilter) {
        self.filter = filter
        fetchDbApples()
    }

    func eatApple(_ appleId: Int) {
        self.networkStorage.eatNetworkApple(appleId).then({ (_ jsonApples: [JsonApple]) -> Void in
            for jsonApple in jsonApples {
                self.dbStorage.updateApple(with: jsonApple).then({
                    self.fetchDbApples()
                })
            }
        })
    }

    func subscribeOnChanges(obj: AnyHashable, block: @escaping VoidBlock) {
        subscribers[obj] = block
    }

    func unsubscribe(obj: AnyHashable) {
        subscribers.removeValue(forKey: obj)
    }

}
