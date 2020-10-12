//
//  Country+CoreDataProperties.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import CoreData

extension Country{
    @NSManaged public var id: String
    @NSManaged public var name: String
    
    static func fetchCountries() -> NSFetchRequest<Country>{
        //        NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        return NSFetchRequest<Country>(entityName: "Country")
    }
    
    static func create(id: String, name: String, context: NSManagedObjectContext){
        let country = Country(context: context)
        country.id = id
        country.name = name
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError) - \(nsError.userInfo)")
        }
    }
    
    static func delete(By id: String, context: NSManagedObjectContext){
        
    }
}
