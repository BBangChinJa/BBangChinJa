//
//  FireStorage.swift
//  BBangChinJa
//
//  Created by EoJin Choi on 5/20/24.
//

import UIKit

import Firebase
import FirebaseStorage

class ImageManager {
    //이미지 업로드
    static func uploadImage(image: UIImage, pathRoot: String, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        let firebaseReference = Storage.storage().reference().child("\(imageName)")
        
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, error in
                if let downloadURL = url {
                    completion(downloadURL)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    //이미지 다운로드
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageRef.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
    
    //이미지 삭제
    static func deleteImage(urlString: String, completion: @escaping(Error?) -> Void) {
        let storageRef = Storage.storage().reference(forURL: urlString)
        
        storageRef.delete { error in
            completion(error)
        }
    }
}
