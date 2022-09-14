//
//  DividendsData.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import Foundation

struct DividendData: Identifiable {
    var name: String
    var count: Double
    var month: String
    var id = UUID()
}

/// Dummy data (temporary)
var data: [DividendData] = [
    //        .init(name: "Div1", count: 50.0, month: "one"),
    //        .init(name: "Div2", count: 60.0, month: "one"),
    .init(name: "6/14 \nPrediction", count: 54.0, month: "6/14"),
    .init(name: "6/14 \nDividend", count: 61.0, month: "6/14"),
    .init(name: "7/1 \nPrediction", count: 49.0, month: "7/1"),
    .init(name: "7/1 \nDividend", count: 57.0, month: "7/1"),
    .init(name: "7/14 \nPrediction", count: 64.0, month: "7/14"),
]
