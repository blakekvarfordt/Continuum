//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
        guard let post = post else { return }
        postImageView.image = post.photo
        captionLabel.text = post.caption
        numberOfCommentsLabel.text = "\(post.commentCount)"
    }

}
