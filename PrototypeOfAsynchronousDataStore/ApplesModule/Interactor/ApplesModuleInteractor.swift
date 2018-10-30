//
//  ApplesModuleApplesModuleInteractor.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

class ApplesModuleInteractor: ApplesModuleInteractorInput {

    weak var output: ApplesModuleInteractorOutput!

    var applesStorage: ApplesStorage!
    
    init(_ applesStorage:ApplesStorage!) {
        self.applesStorage = applesStorage
        
        let key = String(describing: self)
        applesStorage.applesCollection.subscribeOnChanges(obj: key, block: {
            [weak self] () -> Void in
            self?.output.applesDidFetched(self?.apples() ?? [])
        })
    }
    
    deinit {
        let key = String(describing: self)
        self.applesStorage.applesCollection.unsubscribe(obj: key)
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
