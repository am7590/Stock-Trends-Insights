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
        
        // TODO: Add segmented controller to header to select different stocks from portfolio
        
        setTopColor()
        setupViews()
        setupTabBar()
   
    }
    
    private func setTopColor() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGreen
        
        UINavigationBar.appearance().standardAppearance = appearance // for scrolling bg color
        UINavigationBar.appearance().compactAppearance = appearance // not sure why it's here, but u can remove it and still works
        UINavigationBar.appearance().scrollEdgeAppearance = appearance // for large title bg color
        
    }
    
    private func setupViews() {
        //view.backgroundColor = .systemGreen
        
        let homeViewController = DashboardViewController()//HomeViewController(service: IEXApiService())
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







