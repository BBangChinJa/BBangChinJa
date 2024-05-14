//
//  BreadModel.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//
import Foundation

struct NaverSearchResponse: Codable {
	let items: [Bread]
}

struct Bread: Codable {
	let title: String
	let address: String
	let mapx: String
	let mapy: String
}
