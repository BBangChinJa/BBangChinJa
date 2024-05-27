//
//  FireStore.swift
//  BBangChinJa
//
//  Created by EoJin Choi on 5/14/24.
//

import Foundation

import Firebase
import FirebaseFirestore

class ReviewManager {
    static let shared = ReviewManager()
    let db = Firestore.firestore()
    var listener: ListenerRegistration?
    
    deinit {
        listener?.remove()
    }
    
    //MARK: 로그인
    
    //MARK: 회원탈퇴
    
    //MARK: 사용자 id 가져오기
    func getUserID() -> String? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        } else {
            return nil
        }
    }
    
    //MARK: 리뷰 추가
    func addReview(review: Review, completion: @escaping (Error?) -> Void) {
        guard let userID = getUserID() else {
            completion(NSError(domain: "Auth Error", code: 401, userInfo: nil))
            return
        }
        
        let newReview = ReviewManager.shared.db.collection("users").document(userID).collection("reviews").document()
        
        do {
            try newReview.setData(from: review) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                    completion(error)
                } else {
                    self.fetchReview { (review, error) in
                        if let error = error {
                            print("Error fetching reviews after adding a new review: \(error)")
                        }
                    }
                    completion(nil)
                }
            }
        } catch {
            print("Error adding document: \(error)")
            completion(error)
        }
    }
    
    //MARK: 리뷰 조회
    func fetchReview(completion: @escaping ([Review]?, Error?) -> Void) {
        guard let userID = getUserID() else {
            completion([], nil)
            return
        }
        
        let listener = db.collection("users").document(userID).collection("reviews").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var reviews = [Review]()
                for document in querySnapshot!.documents {
                    if let review = try? document.data(as: Review.self) {
                        reviews.append(review)
                    }
                }
                completion(reviews, nil)
            }
        }
    }
    
    //MARK: 리뷰 삭제
    func deleteReview(reviewID: String, imageURL: String, completion: @escaping (Error?) -> Void) {
        guard let userID = getUserID() else {
            completion(NSError(domain: "Auth Error", code: 401, userInfo: nil))
            return
        }
        let dispatch = DispatchGroup()
        
        dispatch.enter()
        ImageManager.deleteImage(urlString: imageURL) { error in
            if let error = error {
                print("Error deleting image from Firebase Storage: \(error)")
            }
            dispatch.leave()
        }
        
        dispatch.notify(queue: .main) {
            self.db.collection("users").document(userID).collection("reviews").document(reviewID).delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                    completion(error)
                } else {
                    print("Review document successfully deleted")
                    completion(nil)
                }
            }
        }
    }
}

