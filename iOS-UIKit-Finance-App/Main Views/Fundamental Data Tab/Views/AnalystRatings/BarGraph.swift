//
//  BarGraph.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct BarGraph: View {
    var trend: [StockDataPoint]
    
    @GestureState var isDragging: Bool = false
    @State var offset: CGFloat = 0
    @State var currentDownloadID: String = ""
    
    var body: some View {
        
        HStack(spacing: 10){
            
            ForEach(trend) { item in
                CardView(download: item)
            }
        }
        .frame(height: 150)
        .animation(.easeOut, value: isDragging)
        .gesture(
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    offset = isDragging ? value.location.x : 0
                    let draggingSpace = UIScreen.main.bounds.width - 60  // 60 padding = 2 * 15 Horizontal
                    let eachBlock = draggingSpace / CGFloat(trend.count)
                    let temp = Int(offset / eachBlock)
                    let index = max(min(temp, trend.count - 1), 0)
                    self.currentDownloadID = trend[index].id
                })
                .onEnded( { value in
                    withAnimation{
                        offset = .zero
                        currentDownloadID = ""
                    }
                })
        )
    }
    
    
    @ViewBuilder
    func CardView(download: StockDataPoint) -> some View {
        VStack(spacing: 20){
            GeometryReader{ proxy in
                let size = proxy.size
                
                RoundedRectangle(cornerRadius: 6)
                    .fill(download.color)
                    .opacity(isDragging ? (currentDownloadID == download.id ? 1 : 0.35) : 1)
                    .frame(height: (download.value / getMax()) * (size.height))
                    .overlay(
                    
                        Text("\(Int(download.value))")
                            .font(.callout)
                            .foregroundColor(download.color)
                            .opacity(isDragging && currentDownloadID == download.id ? 1 : 0)
                            .offset(y: -30)
                        
                        ,alignment: .top
                    )
                    .frame(maxHeight: .infinity,alignment: .bottom)
            }
            
            Text(download.title)
                .font(.callout)
                .foregroundColor(isDragging && currentDownloadID == download.id ? download.color : .gray)
        }
    }
    
    
    func getMax() -> CGFloat {
        let max = trend.max { first, second in
            return second.value > first.value
        }
        
        return max?.value ?? 0
    }
}
