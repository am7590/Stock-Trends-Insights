//
//  DividendsForcastViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/3/22.
//

import Foundation

@MainActor class DividendsForcastViewModel: ObservableObject {
    let service = IEXApiService()
    let stock: String = "GM"
    
    enum State {
        case loading
        case loaded
        case empty(String)
        case error(String)
    }
    
    @Published var dividendsForcast: [DividendsForcast]?
    @Published var state: State = .loading
    
    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getDividendsForcast(stock: stock)
            switch result {
            case .success(let response):
                print(response ?? "")
                self.dividendsForcast = response
                
            case .failure(let error):
                self.dividendsForcast = nil
            }
            state = self.dividendsForcast == nil  ? .loading : .loaded
        }
    }
}
