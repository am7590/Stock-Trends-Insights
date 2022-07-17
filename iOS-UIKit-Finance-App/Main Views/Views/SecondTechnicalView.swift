//
//  SecondTechnicalView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct SecondTechnicalViewFlippingView: View {
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
            SecondTechnicalBack(degree: $frontDegree)
            SecondTechnicalFront(degree: $backDegree)
        }
        
        .onTapGesture {
            flipCard()
        }
    }
    
}

struct SecondTechnicalView: View {
    
    var body: some View {
        Section(content: { SecondTechnicalViewFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: .leading)
    }
}

struct SecondTechnicalFront: View {
//    var title: String
//    var iconSystemName: String
//    var DataView: AnyView
//    var viewModel: AnyClass
    
    @StateObject var viewModel = CompanyTechnicalDataViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            HStack {
                Text("Technical Data")
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
            }.listRowBackground(Color(UIColor.green))
            VStack(alignment: .leading) {
                
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
                
            }.onAppear(perform: { viewModel.load() })
            .listRowBackground(Color(UIColor(red: 0.4, green: 0.8, blue: 0.5, alpha: 1)))
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct SecondTechnicalDataView: View {
    let stats: Stats
    
    var body: some View {
        
        if let year5ChangePercent = stats.year5ChangePercent, let year2ChangePercent = stats.year2ChangePercent {
            Text(String(describing: "year5: \(year5ChangePercent), year2: \(year2ChangePercent)"))
        }
        
        if let year1ChangePercent = stats.year1ChangePercent, let month3ChangePercent = stats.month3ChangePercent {
            Text(String(describing: "year1: \(year1ChangePercent), month3: \(month3ChangePercent)"))
        }
        
        if let month3ChangePercent = stats.month3ChangePercent, let month1ChangePercent = stats.month1ChangePercent, let day5ChangePercent = stats.day5ChangePercent {
            Text(String(describing: "month3: \(month3ChangePercent), month1: \(month1ChangePercent), day5: \(day5ChangePercent)"))
        }
        
        if let debtToEquity = stats.debtToEquity, let profitMargin = stats.profitMargin {
            Text(String(describing: "debtToEquity: \(debtToEquity), profitMargin: \(profitMargin)"))
        }

    }
}


struct SecondTechnicalBack: View {
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

struct SecondTechnicalView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTechnicalView()
    }
}
