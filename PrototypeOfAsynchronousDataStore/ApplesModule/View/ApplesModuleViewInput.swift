//
//  ApplesModuleApplesModuleViewInput.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

protocol ApplesModuleViewInput: class {

    /**
        @author Eugene Kalinin
        Setup initial state of the view
    */

    func setupInitialState()
    
    func updateApples()
}
