//
//  APICall.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/30/22.
//

import UIKit

class APICall {
    
    private var models: [Codable] = []
    
    func fetch() {
        URLSession.shared.request(url: URLs.analystRecommendationsPriceTargets, expecting: [AnalystRecommendationsPriceTargets].self) {
            [weak self] result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self?.models = success
                        print(self?.models)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
}


