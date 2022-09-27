//
//  TimeSeriesHistoricalData.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/27/22.
//

import Foundation

struct TimeSeriesHistoricalData: Codable {
    let close: Double?
    let label: String?
    let minute: String?
    let date: String?
}
