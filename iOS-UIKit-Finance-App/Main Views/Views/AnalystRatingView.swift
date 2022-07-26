//
//  AnalystRatingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
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
            Color(UIColor.secondarySystemBackground)
            AnalystRatingBack(degree: $frontDegree)
            AnalystRatingFront(degree: $backDegree)
        }
        
        .onTapGesture {
            flipCard()
        }
    }
    
}

struct AnalystRatingView: View {
    
    var body: some View {
        Section(content: { AnalystRatingFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .leading)
    }
}

struct AnalystRatingFront: View {
//    var title: String
//    var iconSystemName: String
//    var DataView: AnyView
//    var viewModel: AnyClass
    
    @StateObject var viewModel = AnalystRatingViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        FundamentalDataView(systemImage: "info", title: "Price Target", content: {
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
        })
        .onAppear(perform: { viewModel.load() })
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct AnalystRatingDataView: View {
    let analystRating: AnalystRatings
    
    var body: some View {
        
        if let subkey = analystRating.subkey, let key = analystRating.key {
            Text(String(describing: "subkey (key): \(subkey) (\(key)) "))
        }
        
        if let id = analystRating.id, let symbol = analystRating.symbol {
            Text(String(describing: "Id: \(id) for \(symbol)"))
        }
                
        if let analystCount = analystRating.analystCount, let marketConsensusTargetPrice = analystRating.marketConsensusTargetPrice {
            Text(String(describing: "\(analystCount) analysts predict a price of \(marketConsensusTargetPrice)"))
        }

        if let marketConsensus = analystRating.marketConsensus, let consensusDate = analystRating.consensusDate {
            Text(String(describing: "market consensus \(marketConsensus) on \(consensusDate)"))
        }
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


struct AnalystRatingView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRatingView()
    }
}

