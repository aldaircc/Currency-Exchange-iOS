//
//  ConvertorService.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/14/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation

struct ConvertService: RestAPI {
    
    let url = "https://free.currconv.com/api/v7/countries?apiKey="
    
    func getCurrencies() {
        callService(from: url, verb: "GET", objectType: Currency.self) { (response) in
            switch response {
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            case .success(let data):
                print("Data: \(data)")
            }
        }
    }
}

class Country: Codable{
    let abreviate: String
    
}

class Currency: Codable {
    
    let abreviate: String
}


//Json: {
//results =     {
//    AD =         {
//        alpha3 = AND;
//        currencyId = EUR;
//        currencyName = "European euro";
//        currencySymbol = "\U20ac";
//        id = AD;
//        name = Andorra;
//    };
//    AE =         {
//        alpha3 = ARE;
//        currencyId = AED;
//        currencyName = "UAE dirham";
//        currencySymbol = "\U0641\U0644\U0633";
//        id = AE;
//        name = "United Arab Emirates";
//    };
//    AF =         {
//        alpha3 = AFG;
//        currencyId = AFN;
//        currencyName = "Afghan afghani";
//        currencySymbol = "\U060b";
//        id = AF;
//        name = Afghanistan;
//    };
//    }
//}
