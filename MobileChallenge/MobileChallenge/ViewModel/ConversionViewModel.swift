//
//  ConversionViewModel.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

class ConversionViewModel {
    var conversion: [String : Double]?
    let conversionManager: ConversionManager
    let storage: ConversionStorage
    let monitor: NetworkMonitor

    init(conversionManager: ConversionManager, storage: ConversionStorage, monitor: NetworkMonitor) {
        self.conversionManager = conversionManager
        self.storage = storage
        self.monitor = monitor
    }
    
    func getConversionsData() async throws -> [String : Double] {
        let statusMonitor = try await monitor.checkConnection()
        if statusMonitor == true {
            let conversionResponse = try await conversionManager.fetchRequest()
            if !UserDefaults.standard.bool(forKey: "conversion data salved") {
                storage.saveConversion(conversionResponse: conversionResponse)
                UserDefaults.standard.setValue(true, forKey: "conversion data salved")
            }
            conversion = conversionResponse.quotes
            return conversion ?? [:]
        } else {
            let conversionStorage = storage.fetchConversionStorage()
            let conversionDictionary = conversionStorage.reduce(into: [String : Double]()) { dict, i in
                if let key = i.key {
                    dict[key] = i.value
                }
            }
            return conversionDictionary

        }
    }
                                                                  
                                                               
    


    
    func convertValueAccordingToCurrency(conversionResponse: [String : Double], valueToConvert: String, currencySource: String, currencyDestination: String) -> Double {

        var convertedValue: Double
        var intermediateUSDConversion: Double
        let currencyPair = currencySource + currencyDestination
        let amountToConvert = Double(valueToConvert)
        
 
            for i in conversionResponse {
                if !currencyPair.contains("USD") {
                    if i.key.contains(currencySource) {
                        intermediateUSDConversion = (amountToConvert ?? 0.0) / i.value
                        for i in conversionResponse {
                            if i.key.contains(currencyDestination) {
                                convertedValue = intermediateUSDConversion * i.value
                                return convertedValue
                            }
                        }
                    }
                } else if currencyPair == i.key {
                    convertedValue = (amountToConvert ?? 0.0) * i.value
                    return convertedValue
                }
                
                
            }
        
        
        return 0

    }
    
    
    
    
}



