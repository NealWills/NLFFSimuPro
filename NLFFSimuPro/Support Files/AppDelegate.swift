//
//  AppDelegate.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let mainBaseVC = storyboard.instantiateViewController(withIdentifier: "MainBase")
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = mainBaseVC
        window?.backgroundColor = UIColor.init(white: 1, alpha: 1)
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

}

