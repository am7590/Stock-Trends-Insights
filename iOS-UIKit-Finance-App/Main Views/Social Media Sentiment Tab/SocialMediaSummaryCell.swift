//
//  SocialMediaSummaryCell.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/19/22.
//

import UIKit
import SwiftUI

enum CellType: String, Codable {
    case Twitter
    case Reddit
    case Facebook
    case Stocktwits
    case Wikipedia
}

class SocialMediaSummaryCell: UITableViewCell {
    
    // let viewModel: ViewModel? = nil
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    var cellSubView = UIHostingController(rootView: SocialMediaCellSubView(viewModel: SocialMediaCellViewModel(ticker: WatchlistManager.shared.coreDataTicker, socialMedia: "Twitter")))
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "SocialMediaSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cell: SocialMediaCell) {  // with viewModel: ViewModel
        typeLabel.text = cell.title
        nameLabel.text = cell.detailText
        balanceLabel.text = "Sentiment Value:"
        balanceAmountLabel.text = String(cell.cellValue)
        underlineView.backgroundColor = cell.color
        cellSubView = UIHostingController(rootView: SocialMediaCellSubView(viewModel: SocialMediaCellViewModel(ticker: cell.title, socialMedia: cell.type.rawValue)))
    }
    
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        typeLabel.adjustsFontForContentSizeCategory = true
        //typeLabel.text = "Account type"
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        // underlineView.backgroundColor = appColor
        
        cellSubView.view.translatesAutoresizingMaskIntoConstraints = false
        
        
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
//        nameLabel.adjustsFontSizeToFitWidth = true
//        //nameLabel.text = "Account Name"
//
//        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
//        balanceStackView.axis = .vertical
//        balanceStackView.spacing = 0
//
//        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
//        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
//        balanceLabel.textAlignment = .right
//        balanceLabel.adjustsFontSizeToFitWidth = true
//        //balanceLabel.text = "Some balance"
//
//        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
//        balanceAmountLabel.textAlignment = .right
//        //balanceAmountLabel.text = "929,466.63"
//        // balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cents: "23")
//
//        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
//        let chevronImage = UIImage(systemName: "chevron.right") //!.withTintColor(appColor, renderingMode: .alwaysOriginal)
//        chevronImageView.image = chevronImage
//
//        balanceStackView.addArrangedSubview(balanceLabel)
//        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        contentView.addSubview(typeLabel)  // Add controls to contentView (view of the cell object)
        contentView.addSubview(underlineView)
        

        contentView.addSubview(cellSubView.view)
        //cellSubView.didMove(toParent: self.contentView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(balanceStackView)
//        contentView.addSubview(chevronImageView)

    }
    
    private func layout() {
        
        // Constrains for embedded SwiftUI view
        NSLayoutConstraint.activate([
            cellSubView.view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),
            cellSubView.view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            cellSubView.view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellSubView.view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Constraints for programmatic view
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0.5),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 0.5),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            
//            cellSubView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
//            cellSubView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            
            
//            cellSubView.widthAnchor.constraint(equalToConstant: 60),
//            cellSubView.heightAnchor.constraint(equalToConstant: 4),
            
//            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
//            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
//
//            balanceStackView.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 0),
//            balanceStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
//            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
//
//            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            chevronImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 1)
        ])
        
    }
    
}
