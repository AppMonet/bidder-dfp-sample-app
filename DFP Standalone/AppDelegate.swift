//
//  AppDelegate.swift
//
//  Created by Jose Portocarrero on 9/9/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import UIKit
import CoreData
import AppMonet_Bidder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appMonetConfiguration = AppMonetConfigurations { (config) in
            config?.applicationId = "qw9tp1sy"
        }

        AppMonet.initialize(appMonetConfiguration)
        AppMonet.testMode()
        return true
    }
}

