//
//  StatsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        ZStack {
            Color.green
            Text("This is StatsView")
        }.frame(width: UIScreen.main.bounds.size.width, height: 300, alignment: .center)
    }
    
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
