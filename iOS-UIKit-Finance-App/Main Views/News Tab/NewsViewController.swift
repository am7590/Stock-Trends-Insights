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
    
    var fakeCells: [NewsItem] {
        return [NewsItem(datetime: 1663716407000, headline: "Amazon’s Already Discounting Apple’s Brand New AirPods Pro – SI Showcase", source: "Reuters", url: "", summary: "", image: "", hasPaywall: false)]
    }
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published private var listOfSecurities:[Stock]?
    
    var parser = APIParser()
    var newsArray = [[String]]()
    var newsDataNotLoaded = true
    var loading = true
    let array = ["News", "Array"]
    
    // Chart
    let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
    
    override func viewDidLoad() {
        setupHeader()
        setupTableView()
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
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = UIHostingController(rootView: SentimentDialView(ticker: "TSLA")).view
        var size = headerView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size?.width = UIScreen.main.bounds.width
        size?.height = 216
        headerView?.frame.size = size!
        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
        
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
            // self.listOfSecurities = try context.fetch(Stock.fetchRequest()) // Get all items
            
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
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
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
        guard !fakeCells.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as! NewsTableViewCell
        let data = fakeCells[indexPath.row]
        cell.configure(with: data)
        cell.selectionStyle = .none
        
        return cell

    }
    
 

}


