//
//  FundamentalFlippingViews.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct FirstTechnicalViewFlippingView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let durationAndDelay: CGFloat = 0.2
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            /// Color(UIColor.secondarySystemBackground)
            FirstTechnicalBack(degree: $frontDegree)
            FirstTechnicalFront(degree: $backDegree)
        }
        
        .onTapGesture {
            flipCard()
        }
    }
    
}


struct FirstTechnicalFront: View {
    @StateObject var viewModel = CompanyTechnicalDataViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loaded:
                if let stats = viewModel.stats {
                    FirstTechnicalDataView(stats: stats)
                }
                
            case .error(let error):
                Text(error)
            case .empty(let empty):
                Text(empty)
            default:
                Text("Loading...")
            }
        }
        .onAppear(perform: { viewModel.load() })
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct FirstTechnicalBack: View {
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            Label("Fundamental Data", systemImage: "info.circle.fill")
                .font(.title3)
                .padding(.horizontal)
            Text("Fundamental analysis is the process of evaluating a security to make forecasts about its future price. Fundamental analysis typically includes reviewing  many elements related to stock prices.")
            Button(action: {}, label:{ Link("Learn more", destination: URL(string: "https://www.benzinga.com/money/fundamental-analysis")!)})
        }
        
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}
