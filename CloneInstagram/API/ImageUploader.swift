//
//  ImageUploader.swift
//  CloneInstagram
//
//  Created by Lucky on 21.04.2021.
//

import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard
            let imageData = image.jpegData(compressionQuality: 0.75)
        else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { metadate, error in
            if let error = error {
                print("DEBUG: Failed to upload image: \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
                
            }
        }
        
    }
}
