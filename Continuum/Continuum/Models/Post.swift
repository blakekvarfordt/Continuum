//
//  Post.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import UIKit.UIImage

class Post {
    var photoData: Data?
    let timestamp: Date
    let caption: String
    let comments: [Comment]
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil}
            return UIImage(data: photoData)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(photo: UIImage?, caption: String, comments: [Comment] = [], timestamp: Date = Date()) {
        
    }
}
