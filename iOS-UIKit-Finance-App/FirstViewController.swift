//
//  ViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/21/22.
//

import UIKit

class FirstViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let homeViewController = HomeViewController()
        let newsViewController = NewsViewController()
        let socialMediaViewController = SocialMediaViewController()
        let fundamentalDataViewController = FundamentalDataViewController()
        
        homeViewController.setTabBarImage(imageName: "house", title: "Home")
        newsViewController.setTabBarImage(imageName: "newspaper", title: "News")
        socialMediaViewController.setTabBarImage(imageName: "laptopcomputer.and.iphone", title: "Social Media")
        fundamentalDataViewController.setTabBarImage(imageName: "tablecells", title: "Fundamentals")
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let newsNavigationController = UINavigationController(rootViewController: newsViewController)
        let socialMediaNavigationController = UINavigationController(rootViewController: socialMediaViewController)
        let fundamentalDataNavigationController = UINavigationController(rootViewController: fundamentalDataViewController)
        
        let tabBarList = [homeNavigationController, newsNavigationController, socialMediaNavigationController, fundamentalDataNavigationController]
        viewControllers = tabBarList
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .systemGreen
        tabBar.isTranslucent = false
    }
}







