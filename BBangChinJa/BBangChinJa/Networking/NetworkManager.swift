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
	let kakaoId = Bundle.main.kakao
	
	func searchBakeries(latitude: Double, longitude: Double, completion: @escaping (Result<Data, Error>) -> Void) {
			let query = "빵집"
			let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json?page=1&size=15&sort=distance&query=\(query)&x=\(longitude)&y=\(latitude)&radius=5000"
			
			let headers: HTTPHeaders = [
				"Authorization": "KakaoAK \(kakaoId)"
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
