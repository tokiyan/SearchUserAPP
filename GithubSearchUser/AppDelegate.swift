//
//  AppDelegate.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/18.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let searchUserViewController = R.storyboard.searchUser.instantiateInitialViewController()!

        let navigationController = UINavigationController(rootViewController: searchUserViewController)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return true
    }
}
