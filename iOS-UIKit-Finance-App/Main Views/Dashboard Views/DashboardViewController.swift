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
        
        
        let items = ["TSLA", "GME", "AAPL", "GE"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        
        let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
        
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width-24, height: 28))
        segmentedControl.frame = titleView.bounds
        titleView.addSubview(segmentedControl)
        
        self.navigationItem.titleView = titleView
        
    }
    
    @objc func selectorName() {
        print("")
    }
    
    func layout() {
        scrollView.addSubview(stackView)
        
        // stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(UIHostingController(rootView: GreetingView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: StatsView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: CalendarView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: DividendsView()).view)
        
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
