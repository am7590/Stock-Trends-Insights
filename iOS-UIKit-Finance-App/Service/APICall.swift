//
//  APICall.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/30/22.
//

import UIKit

class APICall {
    
    
    func fetch() {
        // fetchAnalystRatings()
        // fetchIntradayPrice()
    }
    
    func fetchAnalystRatings(ticker: String, completion: @escaping (Result<[AnalystRecommendationsPriceTargets], Error>) -> Void) {
                
        URLSession.shared.request(url: URLs.analystRecommendationsPriceTargets, expecting: [AnalystRecommendationsPriceTargets].self) {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    completion(.success(success))
                    // print(analyst)
                    
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
            
        }
        
    }
    
//    func fetchIntradayPrice() {
//        URLSession.shared.requestL(url: URLs.fetchIntradayPrice, expecting: [[FetchIntradayPrice].self]) {
//            [weak self] result in
//                switch result {
//                case .success(let success):
//                    DispatchQueue.main.async {
//                        self?.models = success
//                        print(self?.modelList)
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
}


