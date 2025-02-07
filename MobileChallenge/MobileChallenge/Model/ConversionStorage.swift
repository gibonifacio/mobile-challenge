//
//  ConversionStorage.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 07/02/25.
//

import Foundation
import CoreData

class ConversionStorage {
    
    let dataManager = DataManager.shared
    
    func saveConversion(conversionResponse: ConversionResponse) {
        for i in conversionResponse.quotes {
            let conversion = Conversion(context: dataManager.context)
            conversion.key = i.key
            conversion.value = i.value
        }
        
        dataManager.saveContext()
    }
    
    func fetchConversionStorage() -> [Conversion] {
        let fetchRequest: NSFetchRequest<Conversion>
        fetchRequest = Conversion.fetchRequest()
        
        do {
            let conversions = try dataManager.context.fetch(fetchRequest)
            return conversions
        } catch {
            print("error to fetch conversion")
            return []
        }
    }
}
