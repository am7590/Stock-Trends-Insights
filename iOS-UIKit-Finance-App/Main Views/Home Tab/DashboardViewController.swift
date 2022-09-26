//
//  DashboardViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import UIKit
import SwiftUI

class DashboardViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    // let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DashboardViewController {
    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
    }
    

    
    @objc func selectorName() {
        print("")
    }
    
    func layout() {
        scrollView.addSubview(stackView)
        stackView.spacing = .leastNonzeroMagnitude
        
        // stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(UIHostingController(rootView: GreetingView(viewModel: GreetingViewModel())).view)
        stackView.addArrangedSubview(UIHostingController(rootView: WatchlistView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: SectorsView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: CurrencyView()).view)
        
        view.addSubview(scrollView)
        
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
