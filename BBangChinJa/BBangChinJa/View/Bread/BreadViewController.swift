//
//  BreadViewController.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//

import UIKit
import NMapsMap
import SnapKit
import CoreLocation

class BreadViewController: UIViewController, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
	var naverMapView: NMFNaverMapView!
	var viewModel = BreadViewModel()
	var markers: [NMFMarker] = [] {
		didSet {
			updateMarkers()
		}
	}
	
	let locationManager = CLLocationManager()
	let fetchButton = UIButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureMapView()
		addMapView()
		addFetchButton()
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
	
	private func configureMapView() {
		naverMapView = NMFNaverMapView(frame: .zero)
		naverMapView.mapView.positionMode = .normal
		//		naverMapView.mapView.moveCamera(NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37.6355125727164, lng: 126.713659327179), zoom: 10)))
		naverMapView.showLocationButton = true
		naverMapView.showZoomControls = true
	}
	
	private func addMapView() {
		view.addSubview(naverMapView)
		naverMapView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	private func addFetchButton() {
		fetchButton.setTitle("주변 빵집 검색", for: .normal)
		fetchButton.setTitleColor(.black, for: .normal)
		fetchButton.backgroundColor = .clear
		fetchButton.addTarget(self, action: #selector(fetchBakeriesAroundCurrentLocation), for: .touchUpInside)
		view.addSubview(fetchButton)
		fetchButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
			make.centerX.equalToSuperview()
			make.width.equalTo(120)
			make.height.equalTo(30)
		}
	}
	
	@objc private func fetchBakeriesAroundCurrentLocation() {
		let cameraPosition = naverMapView.mapView.cameraPosition
		let lat = cameraPosition.target.lat
		let lng = cameraPosition.target.lng
		
		viewModel.fetchBakeries(latitude: lat, longitude: lng) { [weak self] (markers, error) in
			if let error = error {
				print("Error fetching bakeries:", error)
				return
			}
			if let markers = markers {
				self?.clearMarkers()
				self?.markers = markers
			}
			print(lat, lng)
		}
	}
	
	private func clearMarkers() {
		for marker in markers {
			marker.mapView = nil
		}
		markers.removeAll()
	}

	private func updateMarkers() {
		//		naverMapView.mapView.removeOverlays(markers)
		
		for marker in markers {
			marker.mapView = naverMapView.mapView
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			let lat = location.coordinate.latitude
			let lng = location.coordinate.longitude
			let cameraUpdate = NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: lat, lng: lng), zoom: 15))
			naverMapView.mapView.moveCamera(cameraUpdate)
			locationManager.stopUpdatingLocation()
			
			viewModel.fetchBakeries(latitude: lat, longitude: lng) { [weak self] (markers, error) in
				if let error = error {
					print("Error fetching bakeries:", error)
					return
				}
				if let markers = markers {
					self?.clearMarkers()
					self?.markers = markers
				}
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Failed to get user's location: \(error.localizedDescription)")
	}
	
	func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
		print("Tap")
	}
}
