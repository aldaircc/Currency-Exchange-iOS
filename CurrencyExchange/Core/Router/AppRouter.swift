//
//  AppRouter.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import UIKit

class AppRouter: NSObject, Router{
    
    public unowned let navigationController: UINavigationController
    
    var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }
    
    private var completions: [UIViewController: ()-> Void?]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
    }
    
    func toShowable() -> UINavigationController {
        return navigationController
    }
    
    func present(_ module: Showable) {
        
    }
    
    func push(_ module: Showable, animated: Bool, completion: (() -> Void)?) {
        let controller = module.toShowable()
        
        guard controller is UINavigationController == false else { return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        self.navigationController.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        if let controller = navigationController.popViewController(animated: animated){
            runCompletion(controller: controller)
        }
    }
    
    func runCompletion(controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
