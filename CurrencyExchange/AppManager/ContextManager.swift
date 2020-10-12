//
//  ContextManager.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import CoreData

struct ContextManager {
    
    static let shared = ContextManager()
    
    var container: NSPersistentContainer
    var viewContext: NSManagedObjectContext
    var backgroundContext: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "DBExchange")
        container.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error) - \(error.userInfo)")
            }
        }
        
        viewContext = container.viewContext
        backgroundContext = container.newBackgroundContext()
    }
}
