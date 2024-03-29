//
//  DividendsFlippingViews.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct DividendsForcastFlippingView: View {
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
            // Color(UIColor.secondarySystemBackground)
            DividendsForcastBack(degree: $frontDegree)
            DividendsForcastFront(degree: $backDegree)
        }.onTapGesture {
            flipCard()
        }
    }
    
}

struct DividendsForcastFront: View {

    @StateObject var viewModel = DividendsForcastViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
       Group {
           
               switch viewModel.state {
               case .loaded:
                    DividendsForcastDataView(viewModel: viewModel)
               case .error(let error):
                   Text(error)
               case .empty(let empty):
                   Text(empty)
               default:
                   ProgressView()
               }
           //}
            
       }
       .padding()
       .onAppear(perform: { viewModel.load() })
       .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct DividendsForcastBack: View {
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            Label("How accurate is this?", systemImage: "info.circle.fill")
                .font(.title3)
                .padding(.horizontal)
            Text("Employing an algorithm/analyst approach, our data provider Woodseer provides dividend forecast data for 8,500+ equities. This approach enables broad coverage and strong accuracy.")
            Button(action: {}, label:{ Link("Learn more", destination: URL(string: "https://www.woodseerglobal.com/")!)})
        }
        
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}
