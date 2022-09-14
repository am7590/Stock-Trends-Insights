//
//  AnalystFlipViews.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct AnalystRatingFlippingView: View {
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
            AnalystRatingBack(degree: $frontDegree)
            AnalystRatingFront(degree: $backDegree)
        }
        .padding()
        .onTapGesture {
            flipCard()
        }
    }
    
}

struct AnalystRatingFront: View {
    @StateObject var viewModel = AnalystRatingViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
       Group {
            switch viewModel.state {
            case .loaded:
                AnalystRatingDataView(analystRating: viewModel.analystRatings![0])
                
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

struct AnalystRatingBack: View {
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            Label("What are price targets?", systemImage: "info.circle.fill")
                .font(.title3)
                .padding(.horizontal)
            Text("It is a price at which an analyst believes a stock to be fairly valued relative to its projected and historical earnings.")
            Button(action: {}, label:{ Link("Learn more", destination: URL(string: "https://www.investopedia.com/terms/p/pricetarget.asp#:~:text=A%20price%20target%20is%20a,the%20stock%20price%20to%20rise.")!)})
        }

        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

//struct AnalystFlipViews_Previews: PreviewProvider {
//    static var previews: some View {
//        AnalystFlipViews()
//    }
//}
