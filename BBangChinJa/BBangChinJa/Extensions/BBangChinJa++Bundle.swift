//
//  BBangChinJa++Bundle.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//

import Foundation

extension Bundle {
	var idKey: String {
		guard let file = self.path(forResource: "Secrets", ofType: "plist") else { return "" }
		
		guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
		guard let key = resource["NaverID"] as? String else { fatalError("아이디가 필요합니다.") }
		
		return key
	}
}
