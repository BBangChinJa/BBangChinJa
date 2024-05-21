//
//  DataModel.swift
//  BBangChinJa
//
//  Created by EoJin Choi on 5/14/24.
//

import Foundation
import UIKit

struct Review: Codable {
    var id: String?
    var userID: String
    var title: String
    var stars: Int
    var imageURL: String
    var comments: String
}
