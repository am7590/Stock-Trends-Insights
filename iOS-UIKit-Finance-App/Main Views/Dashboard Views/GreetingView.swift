//
//  GreetingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct GreetingView: View {
    var body: some View {
        ZStack {
            Color.red
            
            VStack {
                Text("This is GreetingView")
                Text("This is GreetingView")
                Text("This is GreetingView")
                Text("This is GreetingView")
                Text("This is GreetingView")
                Text("This is GreetingView")
                Text("This is GreetingView")
            }
            
            
        }.cornerRadius(16)
            
            
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
