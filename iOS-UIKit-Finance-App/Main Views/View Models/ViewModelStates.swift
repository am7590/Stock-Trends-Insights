//
//  ViewModelStates.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/12/22.
//

import SwiftUI

class StockAppViewModel: ObservableObject {
   
    enum State {
        case loading
        case loaded
        case empty(String)
        case error(String)
    }
}
