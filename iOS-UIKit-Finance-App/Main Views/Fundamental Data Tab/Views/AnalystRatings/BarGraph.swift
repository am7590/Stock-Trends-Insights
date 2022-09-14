//
//  BarGraph.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

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
    func CardView(download: StockDataPoint) -> some View {
        
        VStack(spacing: 20){
            
            GeometryReader{proxy in
                
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
        let max = downloads.max { first, second in
            return second.value > first.value
        }
        
        return max?.value ?? 0
    }
}
