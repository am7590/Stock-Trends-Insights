//
//  DividendsForcastView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

struct DividendsForcastView: View {
    var body: some View {
        ZStack {
            Color.yellow
            VStack {
                Text("This is DividendsForcastView")
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                Text("Item 4")
            }
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .cornerRadius(16)
            .padding(.horizontal)
        
        
    }
}

struct DividendsForcastView_Previews: PreviewProvider {
    static var previews: some View {
        DividendsForcastView()
    }
}
