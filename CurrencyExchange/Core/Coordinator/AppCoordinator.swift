//
//  AppRouter.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let navigationController: UINavigationController
    var convertCoordinator: ConvertCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        
    }
    
    func start() {
        window.rootViewController = navigationController
        convertCoordinator = ConvertCoordinator(presenter: navigationController)
        convertCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
