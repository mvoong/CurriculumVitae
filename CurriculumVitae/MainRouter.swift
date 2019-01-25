//
//  MainRouter.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 25/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

struct MainRouter {
    
    let window: UIWindow
    
    func presentMainController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RootScene")
        self.window.rootViewController = viewController
        self.window.makeKeyAndVisible()
    }
}
