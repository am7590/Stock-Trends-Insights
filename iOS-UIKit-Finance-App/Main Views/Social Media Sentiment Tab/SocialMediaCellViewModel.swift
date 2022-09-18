//
//  SocialMediaCellViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/18/22.
//

import SwiftUI

@MainActor class SocialMediaCellViewModel: StockAppViewModel {
    let ticker: String
    let socialMedia: String
    
    let service = IEXApiService()
    var dummyData: Sentiment?
    @Published var state: State = .loading
    
    init(ticker: String, socialMedia: String, dummyData: Sentiment? = nil) {
        self.ticker = ticker
        self.socialMedia = socialMedia
        self.dummyData = dummyData
    }
    
    func fetchDummyData() {
        Task(priority: .medium) {
            let result = await service.getDummyData(stock: ticker, socialMedia: socialMedia)
            switch result {
            case .success(let response):
                print(response)
                self.dummyData = response
                
            case .failure(let error):
                print("Couldn't load dummy data: \(error)")
                self.dummyData = nil
            }
            state = self.dummyData == nil ? .loading : .loaded
        }
    }
    
}
