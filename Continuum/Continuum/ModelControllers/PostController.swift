//
//  PostController.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import UIKit.UIImage
import CloudKit

class PostController {
    
    static let shared = PostController()
    
    let messagesWereUpdatedNotification = Notification.Name("messagesWereUpdated")
    
    var posts: [Post] = [] {
        didSet {
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil)
        }
    }
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    func addComment(text: String, post: Post, completion: @escaping (Comment?) -> Void) {
        var commentCount = post.commentCount
        commentCount += 1
        let newComment = Comment(text: text, post: post)
        let commentRecord = CKRecord(comment: newComment)
        post.comments.append(newComment)
        
        publicDB.save(commentRecord) { (_, error) in
            
            if let error = error {
                print("Error with saving the post record in \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            completion(newComment)
            return
        }
    }
    
    func createPostWith(photo: UIImage, caption: String, completion: @escaping (Post?) -> Void) {
        let post = Post(photo: photo, caption: caption)
        let postRecord = CKRecord(post: post)
        self.posts.append(post)
        publicDB.save(postRecord) { (_, error) in
            
            if let error = error {
                print("Error with saving the post record in \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(post)
            return
        }
    }
    
    func fetchPosts(completion: @escaping ([Post]?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: PostStrings.recordTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error with saving the post record in \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let records = records else { completion([]); return }
            
            let posts = records.compactMap({Post(ckRecord: $0)})
            
            self.posts = posts
            
        }
    }
    
    func fetchComments(post: Post, completion: @escaping ([Comment]?) -> Void) {
        let postReference = post.recordID
        let predicate = NSPredicate(format: "%k == %@", CommentStrings.referenceKey, postReference)
        let commentIDs = post.comments.compactMap({$0.ckRecordID})
        let predicate2 = NSPredicate(format: "NOT(recordID IN %@", commentIDs)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        let query = CKQuery(recordType: CommentStrings.recordTypeKey, predicate: compoundPredicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error with saving the post record in \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let records = records else { completion([]); return }
            let comments = records.compactMap({Comment(ckRecord: $0, post: post)})
            post.comments = comments
            
        }
    }
    
    func modifyRecordsOperation() {
        
    }
    
}
