//
//  ChartView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/13/22.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @Environment(\.colorScheme) var scheme
    
    @StateObject var viewModel = ChartViewModel()
    
    // TODO: Fill with real data and move it out of here
    @State var sampleAnalytics: [ChartDataPoint] = []
    
    @State var currentTab: String = "Day"
    @State var currentActiveItem: ChartDataPoint?
    @State var isLineGraph: Bool = true
    
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loaded:
                GeometryReader { proxy in
                    VStack{
                        VStack(alignment: .leading, spacing: 12) {
                            ZStack {
                                VStack {
                                    VStack {
                                        HStack {
                                            Text((viewModel.tickerChartdata.last?.convertToCurrency())!)
                                                .font(.largeTitle.bold())
                                            Spacer()
                                        }
                                        
                                        LineGraph(data: viewModel.tickerChartdata)
                                            .frame(height: 150)
                                    }
                                    
                                    Picker("", selection: $currentTab) {
                                        Text("Day")
                                            .tag("Day")
                                        Text("Week")
                                            .tag("Week")
                                        Text("Month")
                                            .tag("Month")
                                        Text("Year")
                                            .tag("Year")
                                    }
                                    .padding(.top, 8)
                                    .frame(width: proxy.size.width-64)
                                    .pickerStyle(.segmented)
                                }
                                
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
                                        .addBorder(Color.primary.opacity(0.4), width: 1, cornerRadius: 10)     
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding()
                    }
                }
            case .empty(let empty):
                Text("Data is empty: \(empty)")
            case .error(let error):
                Text("Error loading data: \(error)")
            case .loading:
                ProgressView()
            }
        }
        .frame(height: 200)
        .onAppear {
            viewModel.load()
            print("qqo: \(viewModel.tickerChartdata)")
        }
    }
}

struct ChartDataView: View {
    @State var sampleAnalytics: [ChartDataPoint]
    
    var body: some View {
        Chart{
            ForEach(sampleAnalytics) { item in
                    LineMark(
                        x: .value("Hour", item.date, unit: .hour),
                        y: .value("Views", 0)
                    )
                    .foregroundStyle(Color("Blue").gradient)
                    .interpolationMethod(.catmullRom)
                
                
                    AreaMark(
                        x: .value("Hour", item.date, unit: .hour),
                        y: .value("Views", 0)
                    )
                    .foregroundStyle(Color("Blue").opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
            }
        }
        
        // Y-Axis
        // .chartYScale(domain: 0...(max + 150))
    }
}
    
    //struct ChartView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        ChartView_Previews()
    //    }
    //}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
