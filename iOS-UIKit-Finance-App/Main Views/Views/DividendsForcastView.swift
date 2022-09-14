//
//  DividendsForcastView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI
import Charts

struct DividendData: Identifiable {
    var name: String
    var count: Double
    var month: String
    var id = UUID()
}

var data: [DividendData] = [
    //        .init(name: "Div1", count: 50.0, month: "one"),
    //        .init(name: "Div2", count: 60.0, month: "one"),
    .init(name: "6/14 \nPrediction", count: 54.0, month: "6/14"),
    .init(name: "6/14 \nDividend", count: 61.0, month: "6/14"),
    .init(name: "7/1 \nPrediction", count: 49.0, month: "7/1"),
    .init(name: "7/1 \nDividend", count: 57.0, month: "7/1"),
    .init(name: "7/14 \nPrediction", count: 64.0, month: "7/14"),
]

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

struct DividendsForcastView: View {
    
    var body: some View {
        Section(content: { DividendsForcastFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 275, alignment: .leading)
    }
}

struct DividendsForcastFront: View {

    @StateObject var viewModel = DividendsForcastViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
       Group {
           if let forcast =  viewModel.dividendsForcast?[0] {
               switch viewModel.state {
               case .loaded:
                    
                       DividendsForcastDataView(dividendsForcast: forcast)
                   
                   
               case .error(let error):
                   Text(error)
               case .empty(let empty):
                   Text(empty)
               default:
                   Text("Loading...")
               }
           }
            
       }
       .padding()
       .onAppear(perform: { viewModel.load() })
       .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct DividendsForcastDataView: View {
    let dividendsForcast: DividendsForcast
    
    var body: some View {
        
//        if let adjAmount = dividendsForcast.adjustedAmount, let amount = dividendsForcast.amount {
//            Text(String(describing: "Amount (adjusted): \(amount) (\(adjAmount)) "))
//        }
//
//        if let declaredDate = dividendsForcast.declaredDate, let disbursementType = dividendsForcast.disbursementType {
//            Text(String(describing: "Announced \(declaredDate) with \(disbursementType) disbursement  "))
//        }
//
//        if let disbursementAmount = dividendsForcast.disbursementAmount, let frequency = dividendsForcast.frequency {
//            Text(String(describing: "With \(disbursementAmount) every \(frequency)"))
//        }
//
//        if let exData = dividendsForcast.exDate {
//            Text("Must be purchased before \(exData) to get dividend.")
//        }
//
//        if let paymentDate = dividendsForcast.paymentDate {
//            Text("Dividend pays out on \(paymentDate)")
//        }
//
//        if let sharesReceived = dividendsForcast.sharesReceived {
//            Text("with each share receiving \(sharesReceived)")
//        }
        
        VStack {
            
            HStack {
                
                Text("The next dividend payout is 7/14")
                    .font(.largeTitle.bold())
                Spacer()
            }
            
            
            
            Chart  {
                
                ForEach(data) { product in
                    
                    BarMark(x: .value("name", product.name), y: .value("sales", product.count))
                    
                        .foregroundStyle(by: .value("month", product.month))
                    
                        //.position(by: .value("month", product.month))
                    
                }
                
            }
            
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
