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
        
        // label
        //        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.text = "Title"
        //        label.font = UIFont.preferredFont(forTextStyle: .title1)

        
    }
    

    
    @objc func selectorName() {
        print("")
    }
    
    func layout() {
        scrollView.addSubview(stackView)
        stackView.spacing = .leastNonzeroMagnitude
        
        // stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(UIHostingController(rootView: GreetingView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: CalendarView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: StatsView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: GridView()).view)
        
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
