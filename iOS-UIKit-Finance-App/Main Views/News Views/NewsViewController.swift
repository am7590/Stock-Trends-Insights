//
//  NewsViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit
import SwiftUI
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
    let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    
    override func viewDidLoad() {
        // view.backgroundColor = .systemCyan
        setupHeader()
        // fetchSecurities()
        //setupBarChart()
        setupTableView()
        makeSegmentedControl()
    }
    
    private func makeSegmentedControl() {
//        let items = ["TSLA", "GME", "AAPL", "GE"]
//
//        let segmentedControl = UISegmentedControl(items: items)
//        segmentedControl.tintColor = .white
//        segmentedControl.selectedSegmentIndex = 0
//        let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
//
//        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-24, height: 32))
//        titleLabel.text = String("Title")
//
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width-24, height: 28))
//        titleView.frame = CGRect(x: 0, y: 0, width: titleView.bounds.width, height: titleView.bounds.height + titleLabel.bounds.height)
//
//        titleView.addSubview(segmentedControl)
//        titleView.addSubview(titleLabel)
//
//        self.navigationItem.titleView = titleView
    }
    
    func setupHeader() {
//        let header = barChart //AccountSummaryHeaderView(frame: .zero)
//
//        // Layout header is smallest size possible, keep width size of screen
//        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//        size.width = UIScreen.main.bounds.width
//        header.frame.size = size
//
//         tableView.tableHeaderView = header
        
        let headerView = barChart
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        size.height = 300
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
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
        
        tableView.register(UINib(nibName: "NewsCellView", bundle: nil), forCellReuseIdentifier: "NewsCellView")
        tableView.rowHeight = 140
        tableView.clipsToBounds = true
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
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
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
            
            //for item in self.listOfSecurities! {
                getNews(ticker: "AAPL")
                getSentiment(ticker: "AAPL")
            //}
            newsDataNotLoaded = false
            
        } catch {
            
        }
    }
}

extension NewsViewController {
    // MARK: Get API data
    // TODO: Make a ViewModel for this crap
    func getNews(ticker: String) {
        let component : URLComponents = parser.getNewsRequest(ticker: ticker)
        // var returnJSON : [String : Int] = [:]

        let urlRequest = URLRequest(url: component.url!)
        print(urlRequest.url ?? "Failed to load URL")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
    
                // let json = String(data: data, encoding: .utf8)
                let jsonDecoder = JSONDecoder()
                print("qqq: \(String(data: data, encoding: .utf8))")
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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
            
        }).resume()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        } else {
            return newsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellView", for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = .none
        
        if loading {
            cell.headlineLabel.text = "Loading news..."
        } else {
            let news = newsArray[indexPath.row]
            // ["TSLA", "Jul-19-22", "12:16PM", "Chevy Blazer EV SUV coming at the right time, GM exec says", "Yahoo Finance", "https://finance.yahoo.com/news/chevy-blazer-ev-suv-coming-at-the-right-time-gm-exec-says-161636097.html"]
            cell.tickerLabel.text = news[0]
            cell.sourceLabel.text = news[4]
            cell.headlineLabel.text = news[3]
            cell.dateLabel.text = news[2]
            cell.timeLabel.text = news[1]
        }
        
        return cell
    }
}
