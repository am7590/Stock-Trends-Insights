//
//  DashboardViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import UIKit
import SwiftUI

class DashboardViewController: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DashboardViewController {
    func style() {
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(UIHostingController(rootView: GreetingView()).view)
        stackView.addArrangedSubview(UIHostingController(rootView: StatsView()).view)
        
        view.addSubview(stackView)
        
        //view.addSubview(UIView(frame: UIHostingController(rootView: GreetingView())))
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
