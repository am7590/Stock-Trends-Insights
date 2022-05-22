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
    

    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published private var listOfSecurities:[Stock]?
   
    let newsData = NewsData()
//  var sentimentArray = [String:Double]()
//    var dataEntries: [BarChartDataEntry] = []
//    var parser = APIParser()
//    var newsArray = [[String]]()
//    var loading = true
    
    override func viewDidLoad() {
        // view.backgroundColor = .systemCyan
        fetchSecurities()
    }
    



    // MARK: Populate Charts
    func setupBarChart() {
        
        print(newsData.dataEntries)
        //        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Sentimenet")
        //        let chartData = BarChartData(dataSet: chartDataSet)
        //        chartDataSet.colors = ChartColorTemplates.colorful()
        
        //        barChart.data = chartData
    }


    // MARK: Get stock data from CoreData
    func fetchSecurities() {
        do {
            self.listOfSecurities = try context.fetch(Stock.fetchRequest()) // Get all items
            
            for item in self.listOfSecurities! {
                newsData.getNews(ticker: item.name ?? "")
                newsData.getSentiment(ticker: item.name ?? "")
            }
        } catch {
            
        }
    }

}
