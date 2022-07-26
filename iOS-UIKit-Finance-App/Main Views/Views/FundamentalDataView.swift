//
//  FundamentalDataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/25/22.
//

import SwiftUI

struct FundamentalDataView<Content: View>: View {
    let systemImage: String
    let title: String
    let content: Content
    
    init(systemImage: String, title: String, @ViewBuilder content: () -> Content) {
        self.systemImage = systemImage
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Image(systemName: systemImage)
                    .padding(.leading, 15)
                Text(title)
                Spacer()
                
            }.frame(height: 50)
                .background(Color(UIColor.green))
            
            VStack {
                
                self.content
                
            }.padding([.leading, .trailing, .bottom])
            
        }.overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(UIColor.green), lineWidth: 3)
        )
            .cornerRadius(15)
            .padding()
            .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
        
    }
}


struct PlaceholderTextView: View {
    var body: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisiz ut aliquip ex ea commodo consequat. ")
    }
}
