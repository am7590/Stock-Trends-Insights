//
//  DashboardContainerView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/28/22.
//

import SwiftUI

struct DashboardContainerView<Content: View>: View {
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
                    .font(.title)
                Spacer()
                
            }.frame(height: 50)
                
            
            VStack {
                self.content
                
            }.padding([.leading, .trailing, .bottom])
            
        }

        .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
        
    }
}
