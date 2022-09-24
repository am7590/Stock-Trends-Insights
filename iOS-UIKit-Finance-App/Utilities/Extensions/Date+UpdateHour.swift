//
//  Date+UpdateHour.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import Foundation

extension Date{
    func updateHour(value: Int) -> Date{
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}
