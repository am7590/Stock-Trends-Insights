//
//  CurrencyViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import Foundation

@MainActor class CurrencyViewModel: StockAppViewModel {
    let service = IEXApiService()
    
    @Published var currencies: [[Currency]]?
    @Published var state: State = .loading
    
    func load() {
        Task(priority: .medium) {
            let result = await service.getCurrencyData()
            switch result {
            case .success(let response):
                print("zzzz \(response)")
                self.currencies = response.chunked(into: 3)
                state = .loaded
                
            case .failure(let error):
                print("zzz z\(error.customMessage) ")
                self.currencies = nil
                state = .error(error.localizedDescription)
            }
        }
    }
}
