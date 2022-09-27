//
//  ChartDataPoint.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import Foundation

struct ChartDataPoint: Identifiable {
    var id = UUID().uuidString
    var date: Date
    var value: Double
    var animate: Bool = false
}
