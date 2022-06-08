//
//  HomeViewHeaderViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/7/22.
//

import UIKit

class HomeViewHeaderViewController: UIView {
    let stackView = UIStackView()
    let label = UILabel()
    

}

extension HomeViewHeaderViewController {
    func style() {
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        stackView.addArrangedSubview(label)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = .black
    }
    
    // pass in view model: (viewModel: ViewModel)
    func configure() {
        
    }

}
