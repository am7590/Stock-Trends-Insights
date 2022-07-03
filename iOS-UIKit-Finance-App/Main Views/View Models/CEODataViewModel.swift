//
//  CEODataViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/3/22.
//

import Foundation

@MainActor class CEODataViewModel: ObservableObject {
    let service = IEXApiService()
    let stock: String = "TSLA"
    
    enum State {
        case loading
        case loaded
        case empty(String)
        case error(String)
    }
    
    @Published var ceoCompensation: CeoCompensation?
    @Published var state: State = .loading
    
    
    func load() {
        
        Task(priority: .medium) {
            let result = await service.getCeoCompensation(stock: stock)
            switch result {
            case .success(let response):
                print(response ?? "")
                self.ceoCompensation = response
                
            case .failure(let error):
                self.ceoCompensation = nil
            }
            state = self.ceoCompensation == nil  ? .loading : .loaded
        }
    }
}
