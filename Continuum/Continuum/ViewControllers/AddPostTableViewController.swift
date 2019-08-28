//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/27/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addImageButton.setTitle("Select Image", for: .normal)
        imageView.image = nil
        textField.text = ""
    }
    
    
    
    @IBAction func addImageButtonTapped(_ sender: Any) {
        imageView.image = UIImage(named: "blakeKvarfordt")
        addImageButton.setTitle("", for: .normal)
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        guard let image = imageView.image, let caption = textField.text else { return }
        
        PostController.shared.createPostWith(photo: image, caption: caption) { (post) in
            // write code later
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    
    @IBAction func cancelBarButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
}
