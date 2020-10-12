//
//  CountryRepository.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import CoreData

struct CountryRepository {
    
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(id: String, name: String){//country: Country){
//        Country.create(id: country.id, name: country.name, context: <#T##NSManagedObjectContext#>)
        let result = Country.create(id: id, name: name, context: self.context)
    }
    
    func getCountries() -> [Country]{
        let fetchCountry = Country.fetchCountries()
        let result = try? context.fetch(fetchCountry)
        return result ?? []
    }
    
    func filterCountry(by name: String) -> Country{
        
        return Country()
    }
    
    func delete(By id: String) {
        
    }
}
