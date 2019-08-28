//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var postImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        textField.text = ""
    }
    
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        guard let image = postImage, let caption = textField.text else { return }
        
        PostController.shared.createPostWith(photo: image, caption: caption) { (post) in
            // write code later
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    
    
    @IBAction func cancelBarButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPhotoSelectorVC" {
            guard let destination = segue.destination as? PhotoSelectorViewController else { return }
            destination.delegate = self
        }
    }
    
}


extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        self.postImage = image
    }
    
    
}
