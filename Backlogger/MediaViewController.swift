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
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // Allows for the ability to either take a new photo or choose an existing one.
    var imagePicker = UIImagePickerController()
    
    // This variable helps when choosing whether to use the add or update button and whether or not to add a delete button.
    var media : Media? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dictates where image is sent and what to do with it. This code is set within the View Controller.
        imagePicker.delegate = self
        
        // Dictates what type of interface the user is going to get in the Media View Controller.
        if media != nil {
            mediaImageView.image = UIImage(data: media!.image as! Data)
            titleTextField.text = media?.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
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
        // Directs the imagePicker to the user's photolibrary.
        imagePicker.sourceType = .camera
        
        // Allows for displaying the image picker to the user.
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // Function that completes when the add button is tapped.
    @IBAction func addTapped(_ sender: Any) {
        if media != nil {
            media!.title = titleTextField.text
            media!.image = mediaImageView.image!.pngData()
        } else {
            // These constants set up so that we can use the Entities in Core Data.
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let media = Media(context: context)
            
            // Assign the title entered by the user to the Entity.
            media.title = titleTextField.text
            // Assign the image entered by the user to the Entity.
            media.image = mediaImageView.image!.pngData()
        }
        
        // Send completed Media entity to Core Data.
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    // This will delete an entity and update Core Data. Afterwards you will be sent back to the main view controler.
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(media!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)        
    }
}
