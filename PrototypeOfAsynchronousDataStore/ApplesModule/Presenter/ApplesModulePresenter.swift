//
//  ApplesModuleApplesModulePresenter.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

class ApplesModulePresenter: ApplesModuleModuleInput, ApplesModuleViewOutput, ApplesModuleInteractorOutput {
    
    var apples: [Apple] = []
    var appleCount: Int!  {
        get {
            return apples.count
        }
    }
    var filter: AppleFilter! = .all
    
    weak var view: ApplesModuleViewInput!
    var interactor: ApplesModuleInteractorInput!
    var router: ApplesModuleRouterInput!
    
    func obtainApples(_ filter: AppleFilter) {
        self.interactor.fetchApples(filter)
    }
    
    func obtainApple(_ atIndex: Int) -> Apple {
        return self.apples[atIndex]
    }
    
    func applesDidFetched(_ apples:[Apple])
    {
        self.apples = apples
        view.updateApples()
    }
}
