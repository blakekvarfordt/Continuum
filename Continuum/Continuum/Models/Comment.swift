//
//  Comment.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

class Comment {
    let text: String
    let timestamp: Date
    weak var post: Post?
    
    
    init(text: String, timestamp: Date = Date(), post: Post?) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
}

extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        return text.contains(searchTerm) ? true : false
    }
    
    
}
