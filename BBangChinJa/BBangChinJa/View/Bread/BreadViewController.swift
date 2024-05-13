//
//  BreadViewController.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//

import UIKit

class BreadViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		let label = UILabel()
		label.text = "빵뷰"
		label.textColor = .black
		label.textAlignment = .center
		
		view.addSubview(label)

		label.snp.makeConstraints { make in
			make.centerX.centerY.equalToSuperview()
		}
	}
}
