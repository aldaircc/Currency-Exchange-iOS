//
//  Router.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import UIKit

protocol Router {
    
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    
    func present(_ module: Showable)
    func push(_ module: Showable, animated: Bool, completion: (() -> Void)? )
    func pop(animated: Bool)
}
