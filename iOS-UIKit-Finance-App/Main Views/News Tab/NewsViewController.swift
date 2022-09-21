//
//  NewsViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit
import SwiftUI
import CoreData

class NewsViewController: UIViewController {
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published private var listOfSecurities:[Stock]?
    
    var sentimentArray = [String:Double]()
    var parser = APIParser()
    var newsArray = [[String]]()
    var newsDataNotLoaded = true
    var loading = true
    let array = ["News", "Array"]
    
    // Chart
    let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
    
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
        let headerView = UIHostingController(rootView: NewsHeaderView()).view
        var size = headerView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size?.width = UIScreen.main.bounds.width
        size?.height = 300
        headerView?.frame.size = size!
        headerView?.clipsToBounds = true
        tableView.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if newsDataNotLoaded {
            fetchSecurities()
        }
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HostingCell<testView>.self, forCellReuseIdentifier: "newsCell")
        //tableView.rowHeight = 110
        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        //tableView.separatorInset = UIEdgeInsets.zero
        //tableView.layoutMargins = UIEdgeInsets.zero
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Get stock data from CoreData
    func fetchSecurities() {
        do {
            self.listOfSecurities = try context.fetch(Stock.fetchRequest()) // Get all items
            
            //for item in self.listOfSecurities! {
            getNews(ticker: "AAPL")
            
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
//                print("qqq: \(String(data: data, encoding: .utf8))")
                do {
                    let parsedJSON = try jsonDecoder.decode([NewsItem].self, from: data)
                    print("qq news: \(parsedJSON)")
                    
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellView", for: indexPath) as! NewsTableViewCell
//        cell.frame = CGRectMake(0, 0, UIScreen.main.bounds.size.width, 110)
//        cell.selectionStyle = .none
//
//        if loading {
//            cell.headlineLabel.text = "Loading news..."
//        } else {
//            let news = newsArray[indexPath.row]
//            // ["TSLA", "Jul-19-22", "12:16PM", "Chevy Blazer EV SUV coming at the right time, GM exec says", "Yahoo Finance", "https://finance.yahoo.com/news/chevy-blazer-ev-suv-coming-at-the-right-time-gm-exec-says-161636097.html"]
//            cell.tickerLabel.text = news[0]
//            cell.sourceLabel.text = news[4]
//            cell.headlineLabel.text = news[3]
//            // cell.dateLabel.text = news[2]  // Got rid of this
//            cell.timeLabel.text = news[2]
//
//            // TODO: Set cell image here
//        }
//
//        return cell
        
        
        if loading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! HostingCell<testView>
            cell.set(rootView: testView(), parentController: self)
            return cell
            
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! HostingCell<View>
//            cell.host(testView, parent: self)
//            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    struct testView: View {
        var body: some View {
            Text("yay")
                .background(.blue)
        }
    }

}


