//
//  ApplesModuleApplesModulePresenter.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

class ApplesModulePresenter: ApplesModuleModuleInput, ApplesModuleViewOutput, ApplesModuleInteractorOutput {

    weak var view: ApplesModuleViewInput!
    var interactor: ApplesModuleInteractorInput!
    var router: ApplesModuleRouterInput!

    func viewIsReady() {

    }
}
