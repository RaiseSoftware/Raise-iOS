//
//  AppDelegate.swift
//  Raise
//
//  Created by Stephen Hayes on 1/30/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterCrashes
import AppCenterDistribute

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        MSAppCenter.start("be052172-d3f9-4639-8792-0239955245fd", withServices: [MSCrashes.self, MSDistribute.self])

        configureStyles()

        return true
    }

    func configureStyles() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
