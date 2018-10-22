//
//  ApplesModuleApplesModuleInitializer.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

import UIKit

class ApplesModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var applesmoduleViewController: ApplesModuleViewController!

    override func awakeFromNib() {

        let configurator = ApplesModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: applesmoduleViewController)
    }

}
