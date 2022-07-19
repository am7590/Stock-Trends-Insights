//
//  SocialMediaViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit

class SocialMediaViewController: UIViewController {
   
    var tableView = UITableView()
    
    var fakeCells: [SocialMediaCell] {
        return [SocialMediaCell(type: .Twitter, title: "Twitter", color: .blue, detailText: "Detail Text", cellValue: 40.0), SocialMediaCell(type: .Reddit, title: "Reddit", color: .red, detailText: "Detail Text", cellValue: 40.0), SocialMediaCell(type: .Facebook, title: "Facebook", color: .systemBlue, detailText: "Detail Text", cellValue: 40.0), SocialMediaCell(type: .Stocktwits, title: "Stocktwits", color: .green, detailText: "Detail Text", cellValue: 40.0), SocialMediaCell(type: .Wikipedia, title: "Wikipedia", color: .darkGray, detailText: "Detail Text", cellValue: 40.0)]
    }
    
    override func viewDidLoad() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SocialMediaSummaryCell.self, forCellReuseIdentifier: SocialMediaSummaryCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        return 224
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }

}
