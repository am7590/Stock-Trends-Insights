//
//  AnalystRatingsView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/7/22.
//

import UIKit

class AnalystRatingsView: UITableViewCell {

    let stackView = UIStackView()
    let welcomeLabel = UILabel()
    let statusMessage1 = UILabel()
    let statusMessage2 = UILabel()
    let statusMessage3 = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        layout()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 224)
    }
    
    private func setup() {
        
        // labels
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        statusMessage1.translatesAutoresizingMaskIntoConstraints = false
        statusMessage1.text = "statusMessage1"
        statusMessage1.font = UIFont.preferredFont(forTextStyle: .title2)
        
        statusMessage2.translatesAutoresizingMaskIntoConstraints = false
        statusMessage2.text = "statusMessage2"
        statusMessage2.font = UIFont.preferredFont(forTextStyle: .title2)
        
        statusMessage3.translatesAutoresizingMaskIntoConstraints = false
        statusMessage3.text = "statusMessage3"
        statusMessage3.font = UIFont.preferredFont(forTextStyle: .title2)
    }
    
    func layout() {
        // backgroundColor = .systemGreen
        
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(statusMessage1)
        stackView.addArrangedSubview(statusMessage2)
        stackView.addArrangedSubview(statusMessage3)
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func configure(viewModel: ViewModel) {
        welcomeLabel.text = viewModel.welcomeLabel
        statusMessage1.text = viewModel.statusMessage1
        statusMessage2.text = viewModel.statusMessage2
        statusMessage3.text = viewModel.statusMessage3
    }
}
