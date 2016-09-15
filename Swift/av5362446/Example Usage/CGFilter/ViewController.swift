//
//  ViewController.swift
//  CGFilter
//
//  Created by Apollonian on 9/14/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageView = UIImageView(image: UIImage(named: "AZ.png"))
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.contentMode = .redraw
        view.insertSubview(imageView, at: 0)
        picker.delegate = self
    }

    @IBAction func trigger(_ sender: UIBarButtonItem) {
        switch sender.tag{
        case 1:
            imageView.image = Filter.mono(image: imageView.image!)
        case 2:
            picker.allowsEditing = false
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true, completion: nil)
        default:
            imageView.image = UIImage(named: "AZ.png")
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

