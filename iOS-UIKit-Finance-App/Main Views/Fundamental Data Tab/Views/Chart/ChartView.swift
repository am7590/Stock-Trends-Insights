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
    
    // TODO: Fill with real data
    @State var sampleAnalytics: [ChartDataPoint] = [
        ChartDataPoint(hour: Date().updateHour(value: 8), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 9), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 10), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 11), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 12), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 13), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 14), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 15), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 16), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 17), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 18), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 19), views: .random(in: 150...1000)),
        ChartDataPoint(hour: Date().updateHour(value: 20), views: .random(in: 150...1000)),
    ]
    
    @State var currentTab: String = "Day"
    @State var currentActiveItem: ChartDataPoint?
    @State var plotWidth: CGFloat = 0
    
    @State var isLineGraph: Bool = true
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                VStack(alignment: .leading, spacing: 12){
                    
                    let totalValue = sampleAnalytics.reduce(0.0) { partialResult, item in
                        item.views + partialResult
                    }
                    
                    ZStack {
                        VStack {
                            ZStack {
                                AnimatedChart()
                                
                                HStack {
                                    Text("$278.92")
                                        .font(.largeTitle.bold())
                                        .offset(y: -90)
                                    Spacer()
                                }
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
                            .frame(width: proxy.size.width-64)
                            .pickerStyle(.segmented)
                        }
                        
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
                .onChange(of: currentTab) { newValue in
                    sampleAnalytics = sampleAnalytics
                    if newValue != "7 Days"{
                        for (index,_) in sampleAnalytics.enumerated(){
                            sampleAnalytics[index].views = .random(in: 150...1000)
                        }
                    }
                    animateGraph(fromChange: true)
                }
            }
        }
    }
    
    @ViewBuilder
    func AnimatedChart()->some View{
        let max = sampleAnalytics.max { item1, item2 in
            return item2.views > item1.views
        }?.views ?? 0
        
        Chart{
            ForEach(sampleAnalytics){item in
                if isLineGraph{
                    LineMark(
                        x: .value("Hour", item.hour,unit: .hour),
                        y: .value("Views", item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("Blue").gradient)
                    .interpolationMethod(.catmullRom)
                }else{
                    BarMark(
                        x: .value("Hour", item.hour,unit: .hour),
                        y: .value("Views", item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("Blue").gradient)
                }
                
                if isLineGraph{
                    AreaMark(
                        x: .value("Hour", item.hour,unit: .hour),
                        y: .value("Views", item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("Blue").opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                }
                
                // Dragging line
                if let currentActiveItem,currentActiveItem.id == item.id{
                    RuleMark(x: .value("Hour", currentActiveItem.hour))
                    // Dotted Style
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                    // Middle Of each bar
                        .offset(x: (plotWidth / CGFloat(sampleAnalytics.count)) / 2)
                        .annotation(position: .top){
                            VStack(alignment: .leading, spacing: 6){
                                Text("Price")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(currentActiveItem.views.stringFormat)
                                    .font(.title3.bold())
                            }
                            .padding(.horizontal,10)
                            .padding(.vertical,4)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
                            }
                        }
                    
                }
            }
        }
        // Y-Axis
        .chartYScale(domain: 0...(max + 150))
        .chartOverlay(content: { proxy in
            GeometryReader{innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                // Current Location
                                let location = value.location
                                
                                if let date: Date = proxy.value(atX: location.x){
                                    // Hour
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: date)
                                    if let currentItem = sampleAnalytics.first(where: { item in
                                        calendar.component(.hour, from: item.hour) == hour
                                    }){
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                            }.onEnded{value in
                                self.currentActiveItem = nil
                            }
                        
                    )
            }
        })
        .frame(height: 200)
        .onAppear {
            animateGraph()
        }
    }
    
    // MARK: Animating Graph
    func animateGraph(fromChange: Bool = false){
        for (index,_) in sampleAnalytics.enumerated(){
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)){
                withAnimation(fromChange ? .easeInOut(duration: 0.6) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)){
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView_Previews()
//    }
//}



struct ChartDataPoint: Identifiable{
    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false
}
