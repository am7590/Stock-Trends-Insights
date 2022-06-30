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
            Text("This is GreetingView")
        }.frame(width: UIScreen.main.bounds.size.width, height: 300, alignment: .center)
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
