//
//  ApplesModuleApplesModuleInteractor.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

class ApplesModuleInteractor: ApplesModuleInteractorInput {

    weak var output: ApplesModuleInteractorOutput!

    // TODO: inject service here
    private var applesStorage: ApplesStorage = ApplesStorage(networkStorage: NetworkStorage(), dbStorage: DBStorage())
    
    deinit {
        //applesStorage?.applesCollection.unsubscribe(obj: self)
    }

    func fetchApples(_ filter: AppleFilter)
    {
        let key = "Unique key for this interactor"
        applesStorage.applesCollection.subscribeOnChanges(obj: key, block: {
            [weak self] () -> Void in
                self?.output.applesDidFetched()
                self?.applesStorage.applesCollection.unsubscribe(obj: key)
        })
        
        applesStorage.filter = filter
        applesStorage.fetchApples()
    }
}
