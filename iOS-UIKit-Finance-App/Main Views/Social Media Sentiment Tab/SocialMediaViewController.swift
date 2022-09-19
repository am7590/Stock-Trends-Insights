//
//  SocialMediaViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit
import SwiftUI

class SocialMediaViewController: UIViewController {
    let ticker = "TSLA"
    var tableView = UITableView()
    
    // TODO: Refactor
    var fakeCells: [SocialMediaCell] {
        return [SocialMediaCell(type: .Twitter, title: "Twitter", color: .blue, detailText: "1123 tweets were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Reddit, title: "Reddit", color: .red, detailText: "237 reddit posts were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Facebook, title: "Facebook", color: .systemBlue, detailText: "124 facebook posts were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0), SocialMediaCell(type: .Stocktwits, title: "Stocktwits", color: .green, detailText: "1123 tweets were analyzed from the last 24 hours and have a combined sentiment score of", cellValue: 40.0)]
    }
    
    override func viewDidLoad() {
        setupTableView()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SocialMediaSummaryCell.self, forCellReuseIdentifier: SocialMediaSummaryCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = UIHostingController(rootView: SentimentDialView(ticker: ticker)).view
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
}


extension SocialMediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !fakeCells.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SocialMediaSummaryCell.reuseID, for: indexPath) as! SocialMediaSummaryCell
        let data = fakeCells[indexPath.row]
        cell.configure(with: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // TODO: Add nice SwiftUI chart to header
        // Inspiration: https://www.youtube.com/watch?v=ovxLr3HITVY
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Social Media Sentiment"
    }
}
