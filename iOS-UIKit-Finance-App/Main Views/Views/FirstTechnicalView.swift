//
//  FirstTechnicalView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
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

struct FirstTechnicalView: View {
    
    var body: some View {
        Section(content: { FirstTechnicalViewFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 300, alignment: .leading)
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

struct FirstTechnicalDataView: View {
    let stats: Stats
    
    var body: some View {
        FundamentalStats(with: false)
//        if let beta = stats.beta, let EBITDA = stats.EBITDA {
//            Text(String(describing: "beta: \(beta), EBITDA: \(EBITDA)"))
//        }
//
//        if let totalCash = stats.totalCash, let currentDebt = stats.currentDebt {
//            Text(String(describing: "totalCash: \(totalCash), currentDebt: \(currentDebt)"))
//        }
//
//        if let revenue = stats.revenue, let grossProfit = stats.grossProfit {
//            Text(String(describing: "revenue: \(revenue), grossProfit: \(grossProfit)"))
//        }
//
//        if let revenuePerShare = stats.revenuePerShare, let revenuePerEmployee = stats.revenuePerEmployee {
//            Text(String(describing: "revenuePerShare: \(revenuePerShare), revenuePerEmployee: \(revenuePerEmployee)"))
//        }
//
//        if let debtToEquity = stats.debtToEquity, let profitMargin = stats.profitMargin {
//            Text(String(describing: "debtToEquity: \(debtToEquity), profitMargin: \(profitMargin)"))
//        }
        
        
        
    }
}


struct FirstTechnicalBack: View {
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            Label("Technical Data", systemImage: "info.circle.fill")
                .font(.title3)
                .padding(.horizontal)
            Text("Technical Data")
            Button(action: {}, label:{ Link("Learn more", destination: URL(string: "https://www.investopedia.com/terms/p/pricetarget.asp#:~:text=A%20price%20target%20is%20a,the%20stock%20price%20to%20rise.")!)})
        }

        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct CompanyTechnicalData_Previews: PreviewProvider {
    static var previews: some View {
        FirstTechnicalView()
    }
}

@ViewBuilder
func FundamentalStats(with size: Bool)-> some View{
    
    VStack{
                
        HStack(){
            
            Text("Fundamentals")
                .foregroundColor(.black)
                .font(.largeTitle.bold())
                
            Spacer()

        }
        
    
       
            
            if size {
                HStack(spacing: 10){
                    StatView(title: "Volatility", count: "87.57K", image: "newspaper", color: "Green")
                    StatView(title: "D-to-E", count: "27.57K", image: "paperclip", color: "Purple")
                }
                .padding(.top)
            } else {
                VStack {
                    
                    HStack(spacing: 10){
                        StatView(title: "Volatility", count: "87.57K", image: "newspaper", color: "Green")
                        StatView(title: "Debt to Equity", count: "27.57K", image: "paperclip", color: "Purple")
                    }
                    .padding(.top)
                    
                    HStack(spacing: 10) {
                        StatView(title: "Profit Margin", count: "87.57K", image: "newspaper", color: "Green")
                        StatView(title: "Rev. per Share", count: "27.57K", image: "paperclip", color: "Purple")
                    }
//
//                    HStack(spacing: 10) {
//                        StatView(title: "Data 1", count: "87.57K", image: "newspaper", color: "Green")
//                        StatView(title: "Data 2", count: "27.57K", image: "paperclip", color: "Purple")
//                    }
//
//                    HStack(spacing: 10) {
//                        StatView(title: "Data 1", count: "87.57K", image: "newspaper", color: "Green")
//                        StatView(title: "Data 2", count: "27.57K", image: "paperclip", color: "Purple")
//                    }
                }
            }
            
        
    }
    .frame(maxWidth: .infinity)
    .padding(15)
    
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white.shadow(.drop(radius: 2)))
        }
}

@ViewBuilder
func StatView(title: String,count: String,image: String,color: String)->some View{
    
    VStack(alignment: .leading, spacing: 25) {
        
        HStack{
            Image(systemName: image)
                .font(.caption.bold())
                .foregroundColor(Color.white)
                .padding(6)
                .background(Color.black)
                .cornerRadius(8)
            
            Text(title)
        }
        
        Text(count)
            .font(.title.bold())
    }
    .foregroundColor(Color.black)
    .padding(.vertical,22)
    .padding(.horizontal,18)
    .frame(maxWidth: .infinity,alignment: .leading)
    .background(Color.red)
    .cornerRadius(15)
}
