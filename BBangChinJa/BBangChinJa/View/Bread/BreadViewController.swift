//
//  BreadViewController.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//

import UIKit
import NMapsMap
import SnapKit

class BreadViewController: UIViewController {
	var naverMapView: NMFNaverMapView!
	var viewModel = BreadViewModel()
	var markers: [NMFMarker] = [] {
		didSet {
			updateMarkers()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureMapView()
		addMapView()
		
		// BreadViewModel에서 데이터 가져오기
		viewModel.fetchBakeries { [weak self] (markers, error) in
			if let error = error {
				print("Error fetching bakeries:", error)
				return
			}
			if let markers = markers {
				self?.markers = markers
			}
		}
	}
	
	private func configureMapView() {
		naverMapView = NMFNaverMapView(frame: .zero)
		naverMapView.mapView.positionMode = .normal
		naverMapView.mapView.moveCamera(NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37.5666103, lng: 126.9783882), zoom: 10)))
		naverMapView.showLocationButton = true // 현재 위치로 이동하는 버튼 활성화
		naverMapView.showZoomControls = true // 줌 컨트롤 활성화
	}
	
	private func addMapView() {
		view.addSubview(naverMapView)
		naverMapView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	private func updateMarkers() {
		// 이전 마커들 제거
//		naverMapView.mapView.removeOverlays(markers)
		
		// 새로운 마커들 추가
		for marker in markers {
			marker.mapView = naverMapView.mapView
		}
	}
}
