//
//  ApplesModuleApplesModuleViewOutput.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

protocol ApplesModuleViewOutput {

    var appleCount: Int! { get }
    func obtainApple(_ atIndex:Int) -> Apple
  
    func refreshApples()
    func obtainApples(_ filter:AppleFilter)
}
