//
//  ApplesModuleApplesModuleConfigurator.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

import UIKit

class ApplesModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ApplesModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ApplesModuleViewController) {

        let router = ApplesModuleRouter()

        let presenter = ApplesModulePresenter()
        presenter.view = viewController
        presenter.router = router

        // ApplesStorage -> ApplesService
        
        //let storage = ApplesStorage(networkStorage: NetworkStorage(), dbStorage: DBStorage())
        let service = ApplesService(networkStorage: NetworkStorage(), dbStorage: DBStorage())
        let interactor = ApplesModuleInteractor(service)
        
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
