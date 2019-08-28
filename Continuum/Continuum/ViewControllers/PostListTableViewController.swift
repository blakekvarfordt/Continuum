//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostController.shared.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell()}

        let post = PostController.shared.posts[indexPath.row]
        
        cell.postImageView.image = post.photo
        cell.captionLabel.text = post.caption
        cell.numberOfCommentsLabel.text = "\(post.comments.count)"

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPostDetailTableviewController" {
            guard let index = tableView.indexPathForSelectedRow, let destination = segue.destination as? PostDetailTableViewController else { return }
            let post = PostController.shared.posts[index.row]
            destination.post = post
        }
    }
    

}
