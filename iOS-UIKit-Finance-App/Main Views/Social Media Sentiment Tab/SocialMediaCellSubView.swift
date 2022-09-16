//
//  SocialMediaCellSubView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/15/22.
//

import SwiftUI

struct SocialMediaCellSubView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .frame(width: UIScreen.main.bounds.size.width, height: 150)
            .background(.red)
        }
    }
}

struct SocialMediaCellSubView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaCellSubView()
    }
}
