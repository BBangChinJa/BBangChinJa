//
//  BreadViewModel.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//

import Foundation
import NMapsMap

class BreadViewModel {
	var naverMapView: NMFNaverMapView!
	var bakeries: [Bread] = []
	
	func fetchBakeries(completion: @escaping ([NMFMarker]?, Error?) -> Void) {
		NetworkManager.shared.searchBakeries { [weak self] result in
			switch result {
			case .success(let data):
				if let bakeries = self?.createBakeries(from: data) {
					let markers = self?.createMarkers(from: bakeries)
					completion(markers, nil)
				} else {
					completion(nil, NSError(domain: "DecodingError", code: -1, userInfo: nil))
				}
			case .failure(let error):
				completion(nil, error)
			}
		}
	}
	
	private func createBakeries(from data: Data) -> [Bread]? {
		do {
			let decoder = JSONDecoder()
			let result = try decoder.decode(NaverSearchResponse.self, from: data)
			return result.items
		} catch {
			print("JSON decoding error:", error)
			return nil
		}
	}
	
	private func createMarkers(from bakeries: [Bread]) -> [NMFMarker] {
		var markers: [NMFMarker] = []
		for bread in bakeries {
			let latitude = Double(bread.mapy)! / 10_000_000
			let longitude = Double(bread.mapx)! / 10_000_000
			let marker = NMFMarker()
			let infoWindow = NMFInfoWindow()
			let dataSource = NMFInfoWindowDefaultTextSource.data()
			
			dataSource.title = bread.address
			infoWindow.dataSource = dataSource
			marker.position = NMGLatLng(lat: latitude, lng: longitude)
			
			// 마커에 제목 추가
			marker.captionText = bread.title
			
			// 탭 이벤트 처리
			let handler = { (overlay: NMFOverlay) -> Bool in
				if let marker = overlay as? NMFMarker {
					if marker.infoWindow == nil {
						// 현재 마커에 정보 창이 열려있지 않을 경우 엶
						infoWindow.open(with: marker)
					} else {
						// 이미 현재 마커에 정보 창이 열려있을 경우 닫음
						infoWindow.close()
					}
				}
				return true
			}
			marker.touchHandler = handler
			
			markers.append(marker)
		}
		return markers
	}
}
