//
//  ApplesModuleApplesModuleInteractor.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

class ApplesModuleInteractor: ApplesModuleInteractorInput {

    weak var output: ApplesModuleInteractorOutput!

    let key = String(describing: ApplesModuleInteractor.self)
    
    var applesService: ApplesService!

    init(_ applesService: ApplesService!) {
        self.applesService = applesService
        
        self.applesService.subscribeOnChanges(obj: key, block: {
            [weak self] () -> Void in
            guard let strongSelf = self else { return }
            strongSelf.output.applesDidFetched(strongSelf.apples())
        })
    }

    deinit {
        self.applesService.unsubscribe(obj: key)
    }

    func eatApple(_ appleId: Int) {
        self.applesService.eatApple(appleId)
    }

    func fetchApples(_ filter: AppleFilter) {
        self.applesService.fetchDbApplesWithFilter(filter)
    }

    func refreshApples() {
        self.applesService.fetchApples()
    }

    func apples() -> [Apple] {
        return self.applesService.apples
    }
}
