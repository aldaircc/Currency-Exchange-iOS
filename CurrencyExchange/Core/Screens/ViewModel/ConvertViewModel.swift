//
//  ConvertViewModel.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/21/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation
import RxSwift

class ConvertViewModel {
    
    let service: ConvertService
    
    init(service: ConvertService) {
        self.service = service
    }
    
    func getConvertCurrency(currency from:String, to:String, for amount: Float) -> Observable<CurrencyConversion>{
        let params = ConvertParams.init(fromCurrency: from,
                                        toCurrency: to,
                                        amount: amount)
        return self.service.convertCurrency(params: params)
    }
    
}
