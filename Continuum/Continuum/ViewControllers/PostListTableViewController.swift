//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var postSearchBar: UISearchBar!
    
    
    var isSearching = false
    var resultsArray = [Post]()
    var dataSource: [Post] {
        return isSearching ? resultsArray: PostController.shared.posts
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        resultsArray = PostController.shared.posts
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell()}
        
        let post = dataSource[indexPath.row]
        
        cell.post = post
        
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


extension PostListTableViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var newResults: [Post] = []
        guard let searchText = searchBar.text else { return }
        for post in PostController.shared.posts {
            if post.matches(searchTerm: searchText) {
                newResults.append(post)
            }
    }
        resultsArray = newResults
        tableView.reloadData()
  }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        postSearchBar.text = ""
        postSearchBar.resignFirstResponder()
        resultsArray = PostController.shared.posts
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
}
