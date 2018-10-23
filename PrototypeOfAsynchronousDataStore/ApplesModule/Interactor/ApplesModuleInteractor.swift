//
//  ApplesModuleApplesModuleInteractor.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

class ApplesModuleInteractor: ApplesModuleInteractorInput {

    weak var output: ApplesModuleInteractorOutput!

    let key = "Unique key for this interactor"

    // TODO: inject service here
    private var applesStorage: ApplesStorage = ApplesStorage(networkStorage: NetworkStorage(), dbStorage: DBStorage())
    
    init() {
        applesStorage.applesCollection.subscribeOnChanges(obj: self.key, block: {
            [weak self] () -> Void in
            self?.output.applesDidFetched(self?.apples() ?? [])
        })
    }
    
    deinit {
        self.applesStorage.applesCollection.unsubscribe(obj: self.key)
    }
    
    func fetchApples(_ filter: AppleFilter) {
        applesStorage.filter = filter
    }
    
    func refreshApples()
    {
       applesStorage.fetchApples()
    }
    
    func apples() -> [Apple] {
        return self.applesStorage.applesCollection.apples
    }
}
