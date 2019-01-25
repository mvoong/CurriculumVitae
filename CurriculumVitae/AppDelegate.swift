//
//  AppDelegate.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 24/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var mainRouter: MainRouter = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainRouter = MainRouter(window: window)
        return mainRouter
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.mainRouter.presentMainController()
        return true
    }

}

