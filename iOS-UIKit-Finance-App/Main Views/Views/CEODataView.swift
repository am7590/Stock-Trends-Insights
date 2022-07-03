//
//  CEODataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

struct CEODataView: View {
    var body: some View {
        
        ZStack {
            Color.purple
            VStack {
                Text("This is CEODataView")
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                Text("Item 4")
            }
            
        }.frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: .center)
            .cornerRadius(16)
            .padding(.horizontal)
    }
}

struct CEODataView_Previews: PreviewProvider {
    static var previews: some View {
        CEODataView()
    }
}
