//
//  Post.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import UIKit.UIImage
import CloudKit

struct PostStrings {
    static let recordTypeKey = "Post"
    static let photoDataKey = "PhotoData"
    static let captionKey = "Captoin"
    static let timestampKey = "Timestamp"
    static let imageAssetKey = "Photo"
}

class Post {
    let timestamp: Date
    let caption: String
    var comments: [Comment]
    var recordID: CKRecord.ID
    var photoData: Data?
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil}
            return UIImage(data: photoData)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            do {
                try photoData?.write(to: fileURL)
            } catch let error {
                print("Error writing to temp url \(error) \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init(photo: UIImage?, caption: String, comments: [Comment] = [], timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.caption = caption
        self.comments = comments
        self.timestamp = timestamp
        self.recordID = recordID
        self.photo = photo
    }
    
    init?(ckRecord: CKRecord) {
        guard let imageAsset = ckRecord[PostStrings.imageAssetKey] as? CKAsset,
            let caption = ckRecord[PostStrings.captionKey] as? String,
            let timestamp = ckRecord[PostStrings.timestampKey] as? Date else { return nil }

        self.caption = caption
        self.timestamp = timestamp
        self.comments = []
        self.recordID = ckRecord.recordID
        
        guard let url = imageAsset.fileURL else { return }
        
        do {
            self.photoData = try Data(contentsOf: url)
        } catch {
            print("Error with the image data")
        }
    }
    
}


extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if caption.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
    
    
}

extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: PostStrings.recordTypeKey, recordID: post.recordID)
        self.setValue(post.caption, forKey: PostStrings.captionKey)
        self.setValue(post.timestamp, forKey: PostStrings.timestampKey)
        self.setValue(post.imageAsset, forKey: PostStrings.imageAssetKey)
    }
    
}
