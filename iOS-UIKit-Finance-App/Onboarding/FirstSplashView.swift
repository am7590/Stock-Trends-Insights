//
//  FirstSplashView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import SwiftUI

struct FirstSplashView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                let imageSize = proxy.size.width
                Image("logo")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Group {
                    Text("Welcome to ")
                    + Text("Portfolio Insights")
                        .foregroundColor(.green)
                }
                .font(.largeTitle.bold())
                
                Text("Powerful & personalized AI-driven financial data from your fingertips")
                    .font(.title3.bold())
                    .padding(.top, 20)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Image(systemName: "arrow.right")
                        .background(Circle().fill(.green)
                            .frame(width: 50, height: 50))
                        .padding(50)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.NextPage,
                                                            object: nil)
                        }
                }
            }
        }
    }
}

struct FirstSplashView_Previews: PreviewProvider {
    static var previews: some View {
        FirstSplashView()
    }
}
