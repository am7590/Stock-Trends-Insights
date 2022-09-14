//
//  StockDataPoint.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

/// Used to populate the analyst ratings bar graph
public struct StockDataPoint: Identifiable {
    public var id = UUID().uuidString
    var value: CGFloat
    var title: String
    var color: Color
}
