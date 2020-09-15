//
//  ConvertCoordinator.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import UIKit

class ConvertCoordinator: Coordinator {
    
    let presenter: UINavigationController
    var convertVC: ConvertView?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let convertVC = ConvertView(nibName: "ConvertView", bundle: nil)
        convertVC.title = "Currency Exchange"
        self.presenter.pushViewController(convertVC, animated: true)
        self.convertVC = convertVC
    }
}
