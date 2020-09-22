//
//  ConvertViewModel.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/21/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation

class ConvertViewModel {
    
    let service: ConvertService
    
    init(service: ConvertService) {
        self.service = service
    }
    
    func getConvertCurrency(from currencyA:String, to currencyB:String, for amount: Int) {
        self.service.demo()
    }
    
}
