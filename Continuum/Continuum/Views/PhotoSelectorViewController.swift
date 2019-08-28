//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/28/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectorViewControllerSelected(image: UIImage)
}

class PhotoSelectorViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    weak var delegate: PhotoSelectorViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func addImageButton(_ sender: Any) {
        addImageButton.setTitle("", for: .normal)
        selectImageActionSheet()
    }
    
    func selectImageActionSheet() {
        
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self 
        
        let action1 = UIAlertAction(title: "Camera", style: .default) { (_) in
            imagePickerController.sourceType = .camera
            imagePickerController.cameraDevice = .rear
            self.present(imagePickerController, animated: true)
        }
        
        let action2 = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
            
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true)
        
    }
}



extension PhotoSelectorViewController {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.delegate?.photoSelectorViewControllerSelected(image: pickedImage)
            imageView.image = pickedImage
        }
        addImageButton.setTitle("", for: .normal)
        dismiss(animated: true, completion: nil)
        
        
    }
}
