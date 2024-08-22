//
//  TabBarController.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//

import UIKit

class TabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let mangoViewController = MangoViewController()
		
		let breadViewController = BreadViewController()
		
		let rateViewController = RateViewController()
		
		breadViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Bread"), tag: 0)
		mangoViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Drink"), tag: 1)
		rateViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Star"), tag: 2)
		
		viewControllers = [breadViewController, mangoViewController, rateViewController]
		tabBar.isTranslucent = false

		tabBar.tintColor = .gray
		tabBar.unselectedItemTintColor = .lightGray
	}
}
