//
//  AppDelegate.swift
//  PostsManagerApp
//
//  Created by Sebastian Betancur Salazar on 21/07/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let usersView = UsersRouter.createUsersModule()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = usersView
        window?.makeKeyAndVisible()
        
        return true
    }


}

