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
    let countryRepository = CountryRepository(context: ContextManager.shared.viewContext)
    
    init(service: CountryService) {
        self.service = service
    }
    
    func getCountries() -> Observable<ResultCountry> {
        
        //        print("Country from DB")
        //        let countries = countryRepository.getCountries()
        //        for el in countries {
        //            print("id: \(el.id) - name: \(el.name)")
        //        }
        //
        //        return []
        return self.service.getCountries()
    }
    
    func saveCountryDemo(id: String, name: String){
        countryRepository.save(id: id,
                               name: name)
    }
}

struct ResultCountry: Codable{
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    let results: [String: Countryx]
}

struct Countryx: Codable {
    
    let alpha3: String
    let currencyId: String
    let currencyName: String
    let currencySymbol: String
    let name: String
}

//"PE":{"alpha3":"PER",
//    "currencyId":"PEN",
//    "currencyName":"Peruvian nuevo sol",
//    "currencySymbol":"S/.",
//    "id":"PE",
//    "name":"Peru"},
