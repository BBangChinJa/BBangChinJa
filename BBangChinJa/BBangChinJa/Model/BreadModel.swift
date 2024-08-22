//
//  BreadModel.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//
import Foundation

struct NaverSearchResponse: Codable {
	let documents: [Bread]
}

struct Bread: Codable {
	let place_name: String
	let address_name: String
	let x: String
	let y: String
}
