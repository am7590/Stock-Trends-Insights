//
//  NewsCellSubView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/20/22.
//

import SwiftUI

struct NewsCellSubView: View {
    let newsItem: NewsItem 
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
            }
        }
        .background(.red)
        .frame(width: UIScreen.main.bounds.size.width, height: 150)
    }
}

//struct NewsCellSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsCellSubView()
//    }
//}
