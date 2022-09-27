//
//  WatchlistCellView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/25/22.
//

import SwiftUI

struct ChartDataModel: Identifiable, Codable {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var current_price: Double
    var price_change: Double
    var last_7days_price: [Double]
}

@ViewBuilder
func CardView(stock: ChartDataModel) -> some View {
    HStack{
        VStack(alignment: .leading, spacing: 6) {
            Text(stock.name)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(stock.symbol.uppercased())
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 110, alignment: .leading)
        
        LineGraph(data: stock.last_7days_price, profit: stock.price_change > 0)
            .frame(height: 75)
        
        VStack(alignment: .trailing, spacing: 6) {
            Text(stock.current_price.convertToCurrency())
                .font(.title3)
                .fontWeight(.semibold)
            
//            Text("\(stock.price_change > 0 ? "+" : "")\(String(format: "%.2f", stock.price_change))")
//                .font(.caption)
//                .foregroundColor(stock.price_change > 0 ? .green : .red)
        }
    }
}

struct AnimatedGraphPath: Shape{
    var progress: CGFloat
    var points: [CGPoint]
    var animatableData: CGFloat {
        get {
            return progress
        }
        set {
            progress = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            // Drawing animation
            path.move(to: CGPoint(x: 0, y: 0))
            
            path.addLines(points)
        }
        .trimmedPath(from: 0, to: progress)
        .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
    }
}


struct LineGraph: View {
    var data: [Double]
    var profit: Bool = false
    @State var graphProgress: CGFloat = 0  /// represents the animation
    
    var body: some View {

        GeometryReader{proxy in
            
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            let maxPoint = data.max() ?? 0
            let minPoint = data.min() ?? 0
            
            let points = data.enumerated().compactMap { item -> CGPoint in
                let progress = (item.element - minPoint) / (maxPoint - minPoint)
                let pathHeight = progress * (height)
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            ZStack{
                                
                // Path
                AnimatedGraphPath(progress: graphProgress, points: points)
                .fill(
                
                    // Gradient
                    LinearGradient(colors: [
                        profit ? Color.green : Color.red,
                        profit ? Color.green : Color.red,
                    ], startPoint: .leading, endPoint: .trailing)
                )
                
                FillBackground()
                    .clipShape(
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLines(points)
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            path.addLine(to: CGPoint(x: 0, y: height))
                        }
                    )
                    .opacity(graphProgress)
            }
        }
        .padding(.horizontal,10)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 1.2)){
                    graphProgress = 1
                }
            }
        }
        .onChange(of: data) { newValue in
            graphProgress = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 1.2)){
                    graphProgress = 1
                }
            }
        }
    }
    
    @ViewBuilder
    func FillBackground() -> some View{
        let color = profit ? Color.green : Color.red
        LinearGradient(colors: [
            color
                .opacity(0.3),
            color
                .opacity(0.2),
            color
                .opacity(0.1)]
            + Array(repeating: color
                .opacity(0.1), count: 4)
            + Array(repeating: Color.clear, count: 2)
            , startPoint: .top, endPoint: .bottom)
    }
}



// MARK: Converting Double to Currency
extension Double{
    func convertToCurrency()->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter.string(from: .init(value: self)) ?? ""
    }
}
