//
//  GreetingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct GreetingView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Good Morning, Aleksander")
                .font(.title)
            Group {
                Text("The market opens in ") +
                Text("30 minutes")
                    .foregroundColor(.green)
                    .bold()
            }.font(.title2)
            
            Group {
                Text("Your account is up ") +
                Text("0.25% ")
                    .foregroundColor(.green)
                    .bold() +
                Text("{premarket)")
                    .foregroundColor(.gray)
            }
            .font(.title3)
        }.padding(8)
        
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
