//
//  MediaViewController.swift
//  Backlogger
//
//  Created by Alexander Abushady on 7/15/19.
//  Copyright © 2019 Alexander Abushady. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // These are the outlets that link their corresponding fields in the View Controller.
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    // Allows for the ability to either take a new photo or choose an existing one.
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dictates where image is sent and what to do with it. This code is set within the View Controller.
        imagePicker.delegate = self
    }
    // Function that completes when the photos button is tapped.
    @IBAction func photosTapped(_ sender: Any) {
        // Directs the imagePicker to the user's photolibrary.
        imagePicker.sourceType = .photoLibrary
        
        // Allows for displaying the image picker to the user.
        present(imagePicker, animated: true, completion: nil)
    }
    
    //  Allows applying of the selected user image to the imageview.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Set the selected image to a constant of image.
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // Assign the selected image to the image view.
        mediaImageView.image = image
        
        // Dismisses the image picker.
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // Function that completes when the camera button is tapped.
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    // Function that completes when the add button is tapped.
    @IBAction func addTapped(_ sender: Any) {
        // These constants set up so that we can use the Entities in Core Data.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let media = Media(context: context)
        
        // Assign the title entered by the user to the Entity.
        media.title = titleTextField.text
        // Assign the image entered by the user to the Entity.
        media.image = mediaImageView.image!.pngData()
        
        // Send completed Media entity to Core Data.
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
