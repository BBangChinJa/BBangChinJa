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
        
        do {
            try db.collection("users").document(userID).collection("reviews").addDocument(from: review) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        } catch {
            completion(error)
        }
    }
    
    //MARK: 리뷰 조회
    func fetchReview(completion: @escaping ([Review]?, Error?) -> Void) {
        guard let userID = getUserID() else {
            completion([], nil)
            return
        }
        
        listener = db.collection("users").document(userID).collection("reviews").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var reviews = [Review]()
                for document in querySnapshot!.documents {
                    if let review = try? document.data(as: Review.self) {
                        reviews.append(review)
                    }
                }
            }
        }
    }
    
    
    //MARK: 리뷰 삭제
    func deleteReview(reviewID: String, imageURL: [String], completion: @escaping (Error?) -> Void) {
        guard let userID = getUserID() else {
            completion(NSError(domain: "Auth Error", code: 401, userInfo: nil))
            return
        }
        
        // 사진 지우는 코드 추가하기
        let dispatch = DispatchGroup()
        
        dispatch.notify(queue: .main) {
            self.db.collection("users").document(userID).collection("reviews").getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error deleting document: \(error)")
                    completion(error)
                } else {
                    let dispatch = DispatchGroup()
                    for document in querySnapshot!.documents {
                        dispatch.enter()
                        document.reference.delete { error in
                            if let error = error {
                                print("Error deleting document: \(error)")
                            }
                            dispatch.leave()
                        }
                    }
                    dispatch.notify(queue: .main) {
                        completion(nil)
                    }
                }
            }
        }
    }
}

