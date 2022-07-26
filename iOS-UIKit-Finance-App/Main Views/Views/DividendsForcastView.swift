//
//  DividendsForcastView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
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
            Color(UIColor.secondarySystemBackground)
            DividendsForcastBack(degree: $frontDegree)
            DividendsForcastFront(degree: $backDegree)
        }.onTapGesture {
            flipCard()
        }
    }
    
}

struct DividendsForcastView: View {
    
    var body: some View {
        Section(content: { DividendsForcastFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 275, alignment: .leading)
    }
}

struct DividendsForcastFront: View {
    //    var title: String
    //    var iconSystemName: String
    //    var DataView: AnyView
    //    var viewModel: AnyClass
    
    @StateObject var viewModel = DividendsForcastViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        FundamentalDataView(systemImage: "info", title: "Dividends Forcast", content: {
            switch viewModel.state {
            case .loaded:
                if let forcast = viewModel.dividendsForcast?[0] {
                    DividendsForcastDataView(dividendsForcast: forcast)
                }
                
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

struct DividendsForcastDataView: View {
    let dividendsForcast: DividendsForcast
    
    var body: some View {
        
        if let adjAmount = dividendsForcast.adjustedAmount, let amount = dividendsForcast.amount {
            Text(String(describing: "Amount (adjusted): \(amount) (\(adjAmount)) "))
        }
        
        if let declaredDate = dividendsForcast.declaredDate, let disbursementType = dividendsForcast.disbursementType {
            Text(String(describing: "Announced \(declaredDate) with \(disbursementType) disbursement  "))
        }
        
        if let disbursementAmount = dividendsForcast.disbursementAmount, let frequency = dividendsForcast.frequency {
            Text(String(describing: "With \(disbursementAmount) every \(frequency)"))
        }
        
        if let exData = dividendsForcast.exDate {
            Text("Must be purchased before \(exData) to get dividend.")
        }
        
        if let paymentDate = dividendsForcast.paymentDate {
            Text("Dividend pays out on \(paymentDate)")
        }
        
        if let sharesReceived = dividendsForcast.sharesReceived {
            Text("with each share receiving \(sharesReceived)")
        }
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

struct DividendsForcastView_Previews: PreviewProvider {
    static var previews: some View {
        DividendsForcastView()
    }
}
