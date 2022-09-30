//
//  CEOFlipViews.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct CEOFlippingView: View {
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
            Color(UIColor.secondarySystemBackground)
            CEOCompensationBack(degree: $frontDegree)
            CEOCompensationFront(degree: $backDegree)
        }
        .onTapGesture {
            flipCard()
        }
    }
    
}

struct CEOCompensationFront: View {
    @StateObject var viewModel = CEODataViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loaded:
                CEOCompensationView(viewModel: viewModel)
                
            case .error(let error):
                Text(error)
            case .empty(let empty):
                Text(empty)
            default:
                ProgressView()
            }
        }
        .onAppear(perform: { viewModel.load() })
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
        
    }
}

struct CEOCompensationBack: View {
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            Label("Why are CEO's paid with stocks and options?", systemImage: "info.circle.fill")
                .font(.title3)
                .padding(.horizontal)
            Text("CEO's are more incentivized to act on behalf of their shareholders if you pay them a share-based compensation.")
            Button(action: {}, label:{ Link("Learn more", destination: URL(string: "https://www.investopedia.com/articles/stocks/07/executive_compensation.asp#:~:text=Executive%20compensation%20is%20a%20very,and%20boost%20the%20share%20price.")!)})
        }
        
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

//struct CEOFlipViews_Previews: PreviewProvider {
//    static var previews: some View {
//        CEOFlipViews()
//    }
//}
