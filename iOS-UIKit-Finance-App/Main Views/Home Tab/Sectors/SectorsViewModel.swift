//
//  SectorsViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/24/22.
//

import Foundation

@MainActor class SectorsViewModel: StockAppViewModel {
    let service = IEXApiService()
    
    @Published var sectors: [[Sector]]?
    @Published var state: State = .loading
    
    func load() {
        Task(priority: .medium) {
            let result = await service.getSectorData()
            switch result {
            case .success(let response):
                print("zzzz \(response)")
                self.sectors = response.chunked(into: 6)
                state = .loaded
                
            case .failure(let error):
                print("zzz z\(error.customMessage) ")
                self.sectors = nil
                state = .error(error.localizedDescription)
            }
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
