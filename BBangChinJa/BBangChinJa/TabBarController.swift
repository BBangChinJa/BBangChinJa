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
		view.backgroundColor = .white
		
		let breadView = FirstViewController()
		let mangoView = SecondViewController()
		let rateView = ThirdViewController()
		
		breadView.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
		mangoView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
		rateView.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
		
		viewControllers = [breadView, mangoView, rateView]
	}
}

class FirstViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
	}
}

class SecondViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .blue
	}
}

class ThirdViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .green
	}
}
