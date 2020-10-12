//
//  Currency+CoreDataProperties.swift
//  CurrencyExchange
//
//  Created by Aldair Raul Cosetito Coral on 9/28/20.
//  Copyright © 2020 Aldair Cosetito. All rights reserved.
//

import CoreData

extension Currency{
    @NSManaged var currencyId: String
    @NSManaged var currencyName: String
    @NSManaged var currencySymbol: String
}
