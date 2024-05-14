//
//  NetworkManager.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/14/24.
//

import Alamofire
import Foundation

class NetworkManager {
	static let shared = NetworkManager()
	let searchId = Bundle.main.searchId
	let searchSecret = Bundle.main.searchSecret
	
	func searchBakeries(completion: @escaping (Result<Data, Error>) -> Void) {
		let query = "글루텐 프리 빵"
		let urlString = "https://openapi.naver.com/v1/search/local.json?query=\(query)&display=10&start=1"
		
		let headers: HTTPHeaders = [
			"X-Naver-Client-Id": "searchId",
			"X-Naver-Client-Secret": "searchSecret"
		]
		
		AF.request(urlString, headers: headers).responseData { response in
			switch response.result {
			case .success(let data):
				do {
					let json = try JSONSerialization.jsonObject(with: data, options: [])
					print("Data fetched successfully:", json)
				} catch {
					print("Error parsing JSON:", error)
				}
				completion(.success(data))
			case .failure(let error):
				print("Error fetching data:", error)
				completion(.failure(error))
			}
		}
	}
}
