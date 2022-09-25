//
//  WatchlistManager.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import Foundation

class WatchlistManager {
    
    var tickerSelected: String = "AAPL" {
        didSet {
            print("ticker is now \(String(describing: self.tickerSelected))")
        }
    }
    
    static let shared = WatchlistManager()
    
}
