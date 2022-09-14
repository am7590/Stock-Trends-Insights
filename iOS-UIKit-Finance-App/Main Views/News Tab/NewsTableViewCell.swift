//
//  NewsTableViewCell.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/19/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

//    func configure(with news: [String]) {
//        tickerLabel?.text = news[0]
//        headlineLabel?.text = news[1]
//        sourceLabel?.text = news[2]
//        timeLabel?.text = news[3]
//        dateLabel?.text = news[4]
//    }
}
