//
//  String+Extension.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/14/24.
//

import Foundation

extension String {
		var decodedString: String {
				let data = self.data(using: .utf8)!
				let decodedString = String(data: data, encoding: .nonLossyASCII)
				return decodedString ?? self
		}
}
