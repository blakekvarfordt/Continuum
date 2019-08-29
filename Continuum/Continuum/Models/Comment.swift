//
//  Comment.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import CloudKit

struct CommentStrings {
    static let recordTypeKey = "Comments"
    static let textKey = "Text"
    static let timestampKey = "Timestamp"
    static let referenceKey = "CKReference"
}

class Comment {
    let text: String
    let timestamp: Date
    weak var post: Post?
    var ckRecordID: CKRecord.ID
    
    var postReference: CKRecord.Reference? {
        guard let post = post else { return nil }
        return CKRecord.Reference(recordID: post.recordID, action: .deleteSelf)
    }
    
    init(text: String, timestamp: Date = Date(), post: Post?, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
        self.ckRecordID = ckRecordID
    }
    
    init?(ckRecord: CKRecord, post: Post) {
        guard let text = ckRecord[CommentStrings.textKey] as? String,
            let timestamp = ckRecord[CommentStrings.timestampKey] as? Date else { return nil }
        self.text = text
        self.timestamp = timestamp
        self.ckRecordID = ckRecord.recordID
    }
}

extension CKRecord {
    convenience init(comment: Comment) {
        self.init(recordType: CommentStrings.recordTypeKey, recordID: comment.ckRecordID)
        self.setValue(comment.text, forKey: CommentStrings.textKey)
        self.setValue(comment.timestamp, forKey: CommentStrings.timestampKey)
        self.setValue(comment.postReference, forKey: CommentStrings.referenceKey)
    }
}

extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        return text.lowercased().contains(searchTerm.lowercased()) ? true : false
    }
}
