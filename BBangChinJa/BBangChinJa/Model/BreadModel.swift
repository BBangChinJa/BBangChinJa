//
//  BreadModel.swift
//  BBangChinJa
//
//  Created by Dahlia on 5/13/24.
//

import Foundation

import Firebase
import FirebaseFirestore

class StarsManager {
    static let shared = StarsManager()
    let db = Firestore.firestore()
    var listener: ListenerRegistration?
    
    deinit {
        listener?.remove()
    }
    
}
