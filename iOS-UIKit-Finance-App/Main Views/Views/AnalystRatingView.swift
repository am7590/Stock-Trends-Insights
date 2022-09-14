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

struct AnalystRatingView: View {
    
    var body: some View {
        Section(content: { AnalystRatingFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: .leading)
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

struct AnalystRatingDataView: View {
    let analystRating: AnalystRatings
    
    var body: some View {
        
        
        
//        if let subkey = analystRating.subkey, let key = analystRating.key {
//            Text(String(describing: "subkey (key): \(subkey) (\(key)) "))
//        }
//
//        if let id = analystRating.id, let symbol = analystRating.symbol {
//            Text(String(describing: "Id: \(id) for \(symbol)"))
//        }
//
//        if let analystCount = analystRating.analystCount, let marketConsensusTargetPrice = analystRating.marketConsensusTargetPrice {
//            Text(String(describing: "\(analystCount) analysts predict a price of \(marketConsensusTargetPrice)"))
//        }
//
//        if let marketConsensus = analystRating.marketConsensus, let consensusDate = analystRating.consensusDate {
//            Text(String(describing: "market consensus \(marketConsensus) on \(consensusDate)"))
//        }
        
        
        VStack(spacing: 0) {
        
            HStack {
                
                Text("Analyst Ratings")
                    .foregroundColor(.black)
                    .font(.largeTitle.bold())
                Spacer()
            }
           
            
            DownloadStats()
    
            Group {
                Text("Analysts are")
                    .font(.title)
                    //.bold()
                + Text(" bullish")
                    .font(.title)
                    .bold()
                    .foregroundColor(.green)
                + Text("  on TSLA with a price target of")
                    .font(.title)
                    //.bold()
                + Text(" $189.12")
                    .font(.title)
                    .bold()
                    .foregroundColor(.green)
            }
            .frame(height: 100)
            
            Spacer()
            
        }
    }
}

var weekDownloads: [StockDataPoint] = [
    StockDataPoint(downloads: 56, day: "S. Buy", color: Color.green),
    StockDataPoint(downloads: 78, day: "Buy", color: Color.green.opacity(0.8)),
    StockDataPoint(downloads: 42, day: "Hold", color: Color.gray),
    StockDataPoint(downloads: 12, day: "Sell", color: Color.red.opacity(0.8)),
    StockDataPoint(downloads: 5, day: "S. Sell", color: Color.red),
]

@ViewBuilder
func DownloadStats()->some View{
    
    VStack(spacing: 15){
   
        
        // Bar Graph With Gestures...
        BarGraph(downloads: weekDownloads)
            .padding(.top, 5)
    }
    .background(
    
//        RoundedRectangle(cornerRadius: 20)
//            .fill(Color.black)
    )
    .padding(.vertical,20)
}

struct BarGraph: View {
    var downloads: [StockDataPoint]
    
    // Gesture Properties...
    @GestureState var isDragging: Bool = false
    @State var offset: CGFloat = 0
    
    // Current download to highlight while dragging...
    @State var currentDownloadID: String = ""
    
    var body: some View {
        
        HStack(spacing: 10){
            
            ForEach(downloads){download in
                CardView(download: download)
            }
        }
        .frame(height: 150)
        .animation(.easeOut, value: isDragging)
        // Gesutre...
        .gesture(
        
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    // Only updating if dragging...
                    offset = isDragging ? value.location.x : 0
                    
                    // dragging space removing the padding added to the view...
                    // total padding = 60
                    // 2 * 15 Horizontal
                    let draggingSpace = UIScreen.main.bounds.width - 60
                    
                    // Each block...
                    let eachBlock = draggingSpace / CGFloat(downloads.count)
                    
                    // getting index...
                    let temp = Int(offset / eachBlock)
                    
                    // safe Wrapping index...
                    let index = max(min(temp, downloads.count - 1), 0)
                    
                    // updating ID
                    self.currentDownloadID = downloads[index].id
                })
                .onEnded({ value in
                    
                    withAnimation{
                        offset = .zero
                        currentDownloadID = ""
                    }
                })
        )
    }
    
    
    @ViewBuilder
    func CardView(download: StockDataPoint)->some View{
        
        VStack(spacing: 20){
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                RoundedRectangle(cornerRadius: 6)
                    .fill(download.color)
                    .opacity(isDragging ? (currentDownloadID == download.id ? 1 : 0.35) : 1)
                    .frame(height: (download.downloads / getMax()) * (size.height))
                    .overlay(
                    
                        Text("\(Int(download.downloads))")
                            .font(.callout)
                            .foregroundColor(download.color)
                            .opacity(isDragging && currentDownloadID == download.id ? 1 : 0)
                            .offset(y: -30)
                        
                        ,alignment: .top
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            Text(download.day)
                .font(.callout)
                .foregroundColor(isDragging && currentDownloadID == download.id ? download.color : .gray)
        }
    }
    
    
    func getMax()->CGFloat{
        let max = downloads.max { first, second in
            return second.downloads > first.downloads
        }
        
        return max?.downloads ?? 0
    }
}

public struct StockDataPoint: Identifiable{
    public var id = UUID().uuidString
    var downloads: CGFloat
    var day: String
    var color: Color
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

