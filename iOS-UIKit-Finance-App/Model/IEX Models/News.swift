//
//  News.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

struct News: Codable {
    // let datetime: Int64?
    let headline: String?
    let source: String?
    let url: String?
    let summary: String?
    let related: String?
    let image: String?
    let lang: String?
    let hasPaywall: Bool?
}
