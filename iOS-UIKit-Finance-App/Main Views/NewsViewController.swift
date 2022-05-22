//
//  NewsViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit
import CoreData
import Charts

class NewsViewController: UIViewController, ChartViewDelegate {
    

    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published private var listOfSecurities:[Stock]?
   
    var sentimentArray = [String:Double]()
    var dataEntries: [BarChartDataEntry] = []
    var parser = APIParser()
    var newsArray = [[String]]()
    var newsDataNotLoaded = true
    var loading = true
    let array = ["News", "Array"]
    
    // Chart
    var barChart = BarChartView()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        // view.backgroundColor = .systemCyan
        setupHeader()
        // fetchSecurities()
        //setupBarChart()
        setupTableView()
   
    }
    
    func setupHeader() {
        let header = barChart //AccountSummaryHeaderView(frame: .zero)
        
        // Layout header is smallest size possible, keep width size of screen
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBarChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if newsDataNotLoaded {
            fetchSecurities()
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
        tableView.rowHeight = NewsCell.rowHeight
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    

    // MARK: Populate Charts
    func setupBarChart() {
        
        barChart.delegate = self

        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        barChart.invalidateIntrinsicContentSize()
        //barChart.center = view.center
        view.addSubview(barChart)
        
        

    }

    func loadChartData() {
        print("xxx: \(dataEntries)")
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Sentimenet")
        let chartData = BarChartData(dataSet: chartDataSet)
        print("zzz: \(chartDataSet)")
        chartDataSet.colors = ChartColorTemplates.colorful()

       barChart.data = chartData
    }

    // MARK: Get stock data from CoreData
    func fetchSecurities() {
        do {
            self.listOfSecurities = try context.fetch(Stock.fetchRequest()) // Get all items
            
            for item in self.listOfSecurities! {
                getNews(ticker: item.name ?? "")
                getSentiment(ticker: item.name ?? "")
            }
            newsDataNotLoaded = false
            
        } catch {
            
        }
    }

}

extension NewsViewController {
    // MARK: Get API data
    func getNews(ticker: String) {
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
//                //self.tableView.reloadData()
//                self.loadChartData()
//            }
            
            
        }).resume()
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
                    //print(parsedJSON.content)
                    self.sentimentArray = parsedJSON.content
                    
                    //print(self.sentimentArray )
                    
                    var count: Int = 0
                    for item in self.sentimentArray {
                        print(item.value)
                        self.dataEntries.append( BarChartDataEntry(x: Double(count), y: Double(item.value) ))
                        count += 1
                    }
                    
                    print("iii: \(self.sentimentArray)")
                    DispatchQueue.main.async {
                        self.loadChartData()
                    }
                    
                    
                } catch {
                    print("Error parsing JSON")
                }
            }
            
        }).resume()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}


class NewsCell: UITableViewCell {
    static let reuseID = "NewsCell"
    static let rowHeight: CGFloat = 112
}
