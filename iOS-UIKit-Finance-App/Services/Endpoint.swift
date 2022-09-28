//
//  Endpoint.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/20/22.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://alek-api.erwijet.com"  // "http://127.0.0.1:8000"
    }
}
