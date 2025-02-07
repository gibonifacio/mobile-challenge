//
//  CurrencyViewModel.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation


class CurrencyViewModel {
    var currency: [(String, String)]?
    let currencyManager: CurrencyManager

    
    init(currencyManager: CurrencyManager) {
        self.currencyManager = currencyManager
    }
    
    func getCurrencyData() async throws -> [(String, String)] {
        let currencyResponse = try await currencyManager.fetchRequest()
        currency = currencyResponse.currencies.map { ($0.key, $0.value) }
        return currency ?? []
//        return currency ?? CurrencyResponse(currencies: [:])
    }
//    
    func filterCurrency(searchBarText: String) -> [(String, String)] {
        if searchBarText.isEmpty {
            if let currency = currency {
                return currency.sorted {  $0.0 < $1.0  }
            }
        } else {
            let filteredCurrency = currency?.filter { (key,value) in
                key.lowercased().contains(searchBarText.lowercased()) || value.lowercased().contains(searchBarText.lowercased())
            }
            return filteredCurrency ?? []
        }
        return []
    }
    
}
