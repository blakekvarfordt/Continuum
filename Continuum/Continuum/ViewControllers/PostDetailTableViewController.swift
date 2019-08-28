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
        self.tableView.reloadData()
        guard let post = post else { return }
        photoImageView.image = post.photo
    }
    
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        postCommentAlert()
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
        let comment = post.comments[indexPath.row]
        
        cell.textLabel?.text = "\(comment.text)"
        cell.detailTextLabel?.text = "\(comment.timestamp)"

        return cell
    }
    
    
    func postCommentAlert() {
        let alertController = UIAlertController(title: "New Comment", message: "What are your thoughts?", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Type Comment Here!"
        }
        let addCommentAction = UIAlertAction(title: "Post Comment", style: .default) { (_) in
            
            guard let comment = alertController.textFields?.first?.text, !comment.isEmpty else { return }
            guard let post = self.post else { return }
            
            if comment != "" {
                PostController.shared.addComment(text: comment, post: post, completion: { (newComment) in
                    
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(alertCancelAction)
        alertController.addAction(addCommentAction)
        present(alertController, animated: true)
    }

}
