//
//  AnalystRatingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

struct AnalystRatingView: View {
    var body: some View {
        ZStack {
            Color.orange
            VStack {
                Text("This is AnalystRatingView")
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                Text("Item 4")
            }
            
        }.frame(width: UIScreen.main.bounds.size.width, height: 300, alignment: .center)
            .cornerRadius(16)
            .padding(.horizontal)
        
    }
}

struct AnalystRatingView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRatingView()
    }
}
