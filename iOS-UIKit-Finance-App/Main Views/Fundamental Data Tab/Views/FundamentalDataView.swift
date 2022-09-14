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
                //                Image(systemName: systemImage)
                //                    .padding(.leading, 15)
                Text(title)
                    .font(.title)
                Spacer()
                
            }.frame(height: 50)
            
            VStack {
                self.content
            }.padding([.leading, .trailing, .bottom])
        }
        .cornerRadius(15)
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
    }
}
