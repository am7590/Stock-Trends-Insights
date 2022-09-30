//
//  ButtonView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    @State var color: Color = .mint
    
    var body: some View {
        Button(action: {
            WatchlistManager.shared.tickerSelected = title
            color = (color == .mint ? .green : .mint)
           }) {
               Text(title)
                   .frame(minWidth: 0, maxWidth: .infinity)
                   .font(.system(size: 24).bold())
                   .padding()
                   .overlay(
                       RoundedRectangle(cornerRadius: 25)
                           .stroke(Color.secondary, lineWidth: 2)
               )
           }
           .background(color)
           .cornerRadius(25)
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "title")
    }
}
