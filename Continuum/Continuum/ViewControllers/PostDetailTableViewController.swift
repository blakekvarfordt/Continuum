//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {


    @IBOutlet weak var photoImageView: UIImageView!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func updateViews() {
        guard let post = post else { return }
        photoImageView.image = post.photo
        self.tableView.reloadData()
    }
    
    
    @IBAction func commentButtonTapped(_ sender: Any) {

    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func followButtonTapped(_ sender: Any) {
        
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let post = post else { return 0 }
        
        return post.comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell", for: indexPath)

        guard let post = self.post else { return UITableViewCell() }
        
        cell.textLabel?.text = "\(post.comments)"
        cell.detailTextLabel?.text = "\(post.timestamp)"

        return cell
    }
    
    
    func postCommentAlert(comment: Comment?) {
        let alertController = UIAlertController(title: "New Comment", message: "What are your thoughts?", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Type Comment Here!"
        }
        let addCommentAction = UIAlertAction(title: "Post Comment", style: .default) { (_) in
            
            guard let comment = alertController.textFields?.first?.text else { return }
            guard let post = self.post else { return }
            
            if comment != "" {
                PostController.shared.addComment(text: comment, post: post, completion: { (newComment) in
                    
                    if newComment != nil {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(alertCancelAction)
        alertController.addAction(addCommentAction)
    }

}
