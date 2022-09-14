//
//  SearchResults.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/21/22.
//

import Foundation
 
struct SearchResults: Decodable {
    
    let items: [SearchResult]
 
    enum CodingKeys: String, CodingKey {
        case items = "bestMatches"
    }
    
}
 
 
struct SearchResult: Decodable {
    let symbol: String
    let name: String
    let type: StringLiteralType
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
    
}
 
