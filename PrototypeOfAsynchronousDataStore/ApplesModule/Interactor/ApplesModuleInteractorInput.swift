//
//  ApplesModuleApplesModuleInteractorInput.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

import Foundation

protocol ApplesModuleInteractorInput {

    func eatApple(_ appleId: Int)
    func refreshApples()
    func fetchApples(_ filter: AppleFilter)
}
