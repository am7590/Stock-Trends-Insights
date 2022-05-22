//
//  NewsViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit
import CoreData
import Charts

class NewsViewController: UIViewController {
    
    var parser = APIParser()
    var newsArray = [[String]]()
    var loading = true
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published private var listOfSecurities:[Stock]?
    var sentimentArray = [String:Double]()
    var dataEntries: [BarChartDataEntry] = []
    
    override func viewDidLoad() {
        view.backgroundColor = .systemCyan
        fetchSecurities()
    }
    
}


// MARK: Populate Charts
extension NewsViewController {
    
    func setupBarChart() {
        
        print(dataEntries)
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Sentimenet")
//        let chartData = BarChartData(dataSet: chartDataSet)
//        chartDataSet.colors = ChartColorTemplates.colorful()
//
//        barChart.data = chartData
    }
}

// MARK: Get stock data from CoreData

extension NewsViewController {

    
    func fetchSecurities() {
        do {
            self.listOfSecurities = try context.fetch(Stock.fetchRequest()) // Get all items
            print(self.listOfSecurities?.count)
            
            for item in self.listOfSecurities! {
                getNews(ticker: item.name ?? "")
                getSentiment(ticker: item.name ?? "")
            }
        } catch {
            
        }
    }
    
    // MARK: Get API data
    private func getNews(ticker: String) {
        let component : URLComponents = parser.getNewsRequest(ticker: ticker)
        // var returnJSON : [String : Int] = [:]

        let urlRequest = URLRequest(url: component.url!)
        print(urlRequest.url ?? "Failed to load URL")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
    
                // let json = String(data: data, encoding: .utf8)
                let jsonDecoder = JSONDecoder()
                
                do {
                    let parsedJSON = try jsonDecoder.decode(NewsStruct.self, from: data)
                           
                    self.newsArray += (parsedJSON.content)
                    
                    
                    self.newsArray = self.newsArray.sorted(by: {
                        ($0[1], $0[2]) > ($1[1], $1[2])
                    })
                    
                    print(self.newsArray)

                } catch {
                    print("Error parsing JSON")
                }
            }
            
            self.loading = false
            
            // Reload tableview
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
            
            
        }).resume()
    }

    
    private func getSentiment(ticker: String) {
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
                    //print(parsedJSON.content)
                    self.sentimentArray = parsedJSON.content
                    
                    //print(self.sentimentArray )
                    
                    var count: Int = 0
                    for item in self.sentimentArray {
                        print(item.value)
                        self.dataEntries.append( BarChartDataEntry(x: Double(count), y: Double(item.value) ))
                        count += 1
                    }
                    self.setupBarChart()
                    
                    print(self.sentimentArray)
                    
                } catch {
                    print("Error parsing JSON")
                }
            }
            
        }).resume()
    }

}
