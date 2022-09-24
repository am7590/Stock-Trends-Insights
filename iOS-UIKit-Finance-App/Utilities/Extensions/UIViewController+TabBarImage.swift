//
//  UIViewController+TabBarImage.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit

extension UIViewController {

    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
}
