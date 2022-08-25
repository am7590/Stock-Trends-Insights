//
//  NewsHeaderView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/24/22.
//

import SwiftUI
import Charts

struct NewsHeaderView: View {
    
    var parser = APIParser()
    var sentimentArray = [String:Double]()
    @State var data: [ChartData] = []
    
    var body: some View {
        Chart {
            ForEach(data) { shape in
                    BarMark(
                        x: .value("Shape Type", shape.day),
                        y: .value("Total Count", shape.value)
                    )
                }
        }.onAppear {
            if data.isEmpty {
                getSentiment(ticker: "SPY")
            }
        }
    }
    
    func getSentiment(ticker: String) {
        let component : URLComponents = parser.getSentimentRequest(ticker: ticker)
        // var returnJSON : [String : Int] = [:]

        let urlRequest = URLRequest(url: component.url!)
        print(urlRequest.url ?? "Failed to load URL")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {

                // let json = String(data: data, encoding: .utf8)
                let jsonDecoder = JSONDecoder()
                
                do {
                    let parsedJSON = try jsonDecoder.decode(SentimentStruct.self, from: data)
                    print("zz: \(parsedJSON.content)")
                                        
                    var count: Int = 0
                    for item in parsedJSON.content {
                        print("zz: \(item.value)")
                        if count > 10 {
                            break
                        }
                        self.data.append( .init(day: item.key, value: item.value)  )
                        count += 1
                    }
    //
    //                print("iii: \(self.sentimentArray)")
    //                DispatchQueue.main.async {
    //                    self.loadChartData()
    //                }
                    
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
            
        }).resume()
    }
}

struct NewsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NewsHeaderView()
    }
}

struct ChartData: Identifiable {
    var day: String
    var value: Double
    var id = UUID()
}
