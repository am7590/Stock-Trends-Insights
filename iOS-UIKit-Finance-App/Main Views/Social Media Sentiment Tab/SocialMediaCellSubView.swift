//
//  SocialMediaCellSubView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/15/22.
//

import SwiftUI
import Charts

struct SocialMediaCellSubView: View {
    @StateObject var viewModel: SocialMediaCellViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                LoadedCellView(viewModel: viewModel)
            default:
                Text("Loading...")
            }
        }.onAppear(perform: {
            viewModel.fetchDummyData()
        })
    }
}

struct SocialMediaCellSubView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaCellSubView(viewModel: SocialMediaCellViewModel(ticker: "TSLA", socialMedia: "Twitter"))
    }
}


struct LoadedCellView: View {
    @StateObject var viewModel: SocialMediaCellViewModel

    var body: some View {
        let sentimentScore: Double = viewModel.dummyData?.sentimentScore ?? 69.69
        let sentimentText: String = sentimentScore < 33.33 ? "Bearish" : (sentimentScore < 66.33 ? "Neutral" : "Bullish")
        let postsAnalyzed: String = String(viewModel.dummyData?.itemsScanned ?? 0)
        let textColor: Color = sentimentScore < 33.33 ? .red : (sentimentScore < 66.33 ? .gray : .green)
        
        GeometryReader { proxy in
            
            HStack {
                VStack(alignment: .leading) {
                    
                    
                    
                    Text(sentimentText)
                        .font(.largeTitle.bold())
                        .foregroundColor(textColor)
                    + Text("  (\(String(sentimentScore))%)")
                        .font(.title2)
                    
//                    Group {
//                        Text("From ")
//                        + Text(postsAnalyzed)
//                            .bold()
//                        + Text(" analyzed posts")
//                    }.font(.title3)
                    
                }
                .padding(.top, 50)
                
                Spacer()
                
                Chart {
                     
                    // TODO: This is dummy data and will be deleted...
                    let dummyData: [(text: String, value: Int)] = [
                        (text: "Bearish", value: Int(sentimentScore < 33.33 ? 100-sentimentScore : sentimentScore/2)),
                        (text: "Neutral", value: Int(sentimentScore > 33.33 && sentimentScore < 66.66 ? sentimentScore : sentimentScore/2.5)),
                        (text: "Bullish", value: Int(sentimentScore > 66.66 ? sentimentScore : sentimentScore/3)),
                    ]
                    
                    ForEach(dummyData, id: \.value) {
                        BarMark(
                            x: .value("Value", $0.value),
                            y: .value("Text", $0.text)
                        )
                        .foregroundStyle(by: .value("Text", $0.text))
                        
                    }
                }
                
                .frame(width: proxy.size.width/3, height: 120)
                .chartForegroundStyleScale(["Bearish": .red, "Neutral": .gray, "Bullish": .green])
                .chartLegend(Visibility.hidden)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, height: 150)
    }
}

// return [SocialMediaCell(type: .Twitter, title: "Twitter", color: .blue, detailText: "1123 tweets were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Reddit, title: "Reddit", color: .red, detailText: "237 reddit posts were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Facebook, title: "Facebook", color: .systemBlue, detailText: "124 facebook posts were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Stocktwits, title: "Stocktwits", color: .green, detailText: "1123 tweets were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Wikipedia, title: "Wikipedia", color: .darkGray, detailText: "1 wikipedia post was analyzed and its sentiment score is", cellValue: 40.0)]
