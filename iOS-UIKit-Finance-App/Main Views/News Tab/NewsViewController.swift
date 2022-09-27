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
    @Published private var listOfSecurities: [Stock]?
    
    var parser = APIParser()
    var newsArray = [NewsItem]()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
            // TODO: Error handling...
        }
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
        guard !newsArray.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath)
        let newsData = NewsViewModel(ticker: "AAPL", news: newsArray[indexPath.row]).news
        let dateString = Date(timeIntervalSince1970: (newsData?.datetime ?? 0.0)/1000).timeAgoDisplay()
        let image = newsData?.image ?? ""
        
        DispatchQueue.main.async {
            cell.contentConfiguration = UIHostingConfiguration { 
                HStack {
                    VStack {
                        
                        Spacer()
                        
                        
                            Group {
                                if image == "https://storage.googleapis.com/iexcloud-hl37opg/images/iex_cloud_image.png" {
                                    Image("apple")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 110, height: 110)
                                        .cornerRadius(15)
                                } else {
                                    AsyncImage(url: URL(string: image)) { [weak self] image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 110, height: 110)
                                    .cornerRadius(15)
                                }
                            }
                            
                        
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(newsData?.source ?? ".")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(newsData?.headline ?? ".")
                            .font(.title3.bold())
                        Text(dateString)
                            .font(.callout)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                    
                    
                }
                
            }
        }
        
        
        return cell
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

// TODO: Make a ViewModel for this crap
extension NewsViewController {
    func getNews(ticker: String) {
        let component : URLComponents = parser.getNewsRequest(ticker: ticker)
        let urlRequest = URLRequest(url: component.url!)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode([NewsItem].self, from: data)
                    self.newsArray = parsedJSON
                    
                } catch {
                    // TODO: Error handling...
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


