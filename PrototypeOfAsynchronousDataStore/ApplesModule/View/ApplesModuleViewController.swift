//
//  ApplesModuleApplesModuleViewController.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 rich. All rights reserved.
//

import UIKit

class ApplesModuleViewController: UIViewController, ApplesModuleViewInput {

    var output: ApplesModuleViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: ApplesModuleViewInput
    func setupInitialState() {
    }
}
