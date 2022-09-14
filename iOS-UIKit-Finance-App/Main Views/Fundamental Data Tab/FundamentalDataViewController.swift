//
//  FundamentalDataViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit
import SwiftUI

class FundamentalDataViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension FundamentalDataViewController {
    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        //stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.backgroundColor = .secondarySystemBackground
    }
    
    func layout() {
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(UIHostingController(rootView: CompanyHeaderView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: CEODataView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: AnalystRatingView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: FirstTechnicalView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: SecondTechnicalView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: DividendsForcastView()).view)
        
        
        view.addSubview(scrollView)
        view.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        
    }
}

