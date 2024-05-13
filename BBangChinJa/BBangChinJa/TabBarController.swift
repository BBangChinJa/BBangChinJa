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
		
		breadViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
		mangoViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
		rateViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
		
		viewControllers = [breadViewController, mangoViewController, rateViewController]
	}
}
