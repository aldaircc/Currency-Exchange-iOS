//
//  Constants.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation

struct API {
    static let baseURL = "https://free.currconv.com/api/v7/"
    static let apiKey = "cdb7a9483e3f8baf3e6c"
    
    enum EndPoints: String {
        case live = "live"
        case historical = "historical"
        case convert = "convert"
        case timeFrame = "timeframe"
        case change = "change"
        case countries = "countries"
    }
}

//Convert
//https://free.currconv.com/api/v7/convert?q=USD_PEN&compact=ultra&apiKey=cdb7a9483e3f8baf3e6c

//Countries
//https://free.currconv.com/api/v7/countries?apiKey=cdb7a9483e3f8baf3e6c



//https://www.currencyconverterapi.com/docs
