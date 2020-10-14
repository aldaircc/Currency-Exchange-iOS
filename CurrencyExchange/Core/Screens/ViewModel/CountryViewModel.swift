//
//  CountryViewModel.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/26/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import Foundation
import RxSwift

struct CountryViewModel {
    
    let service: CountryService
    
    init(service: CountryService) {
        self.service = service
    }
    
    func getCountries() -> Observable<ResultCountry> {
        return self.service.getCountries()
    }
}

struct ResultCountry: Codable{
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    let results: [String: Country]
}

struct Country: Codable {
    
    let alpha3: String
    let currencyId: String
    let currencyName: String
    let currencySymbol: String
    let name: String
}
