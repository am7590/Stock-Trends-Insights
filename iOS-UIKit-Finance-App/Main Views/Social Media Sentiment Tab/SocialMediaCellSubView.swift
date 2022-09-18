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
    
    let dummyData: [(text: String, value: Int)] = [
      (text: "Bearish", value: .random(in: 0...33)),
      (text: "Neutral", value: .random(in: 0...33)),
      (text: "Bullish", value: .random(in: 0...33)),
    ]
    
    var body: some View {
        GeometryReader { proxy in
            
            switch viewModel.state {
            case .loaded:
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text(String(viewModel.dummyData?.sentimentScore ?? 69.69))
                            .font(.largeTitle.bold())
                        
                        Text("From " + String(viewModel.dummyData?.itemsScanned ?? 0) + " analyzed tweets")
                            .font(.title3)
                        
    //                    Text("1123 tweets ")
    //                    + Text("were analyzed from the last ")
    //                    + Text("24 hours ")
    //                    + Text("and have a combined sentiment score of ")

                    }
                    
                    Spacer()
                    
                    Chart {
                      ForEach(dummyData, id: \.value) {
                        BarMark(
                          x: .value("Value", $0.value),
                          y: .value("Text", $0.text)
                         

                        )
                      }
                    }
                    .frame(width: proxy.size.width/3, height: 125)
                    
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.size.width, height: 150)
                
            default:
                Text("Loading...")
            }
            
           
            // .background(.red)
            
            
            

           
        }.onAppear(perform: { viewModel.fetchDummyData() })
    }
}

struct SocialMediaCellSubView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaCellSubView(viewModel: SocialMediaCellViewModel(ticker: "TSLA", socialMedia: "Twitter"))
    }
}


// return [SocialMediaCell(type: .Twitter, title: "Twitter", color: .blue, detailText: "1123 tweets were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Reddit, title: "Reddit", color: .red, detailText: "237 reddit posts were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Facebook, title: "Facebook", color: .systemBlue, detailText: "124 facebook posts were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Stocktwits, title: "Stocktwits", color: .green, detailText: "1123 tweets were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Wikipedia, title: "Wikipedia", color: .darkGray, detailText: "1 wikipedia post was analyzed and its sentiment score is", cellValue: 40.0)]
