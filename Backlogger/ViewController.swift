//
//  ViewController.swift
//  Backlogger
//
//  Created by Alexander Abushady on 7/15/19.
//  Copyright © 2019 Alexander Abushady. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // This outlet is for the table view.
    @IBOutlet weak var tableView: UITableView!
    
    // This array will allow for showing the Core Data in the Table View.
    var mediaArray : [Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assigns the how many cells and what are in the cells in the table view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Context allows for interaction with Core Data.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            // This will allow the table view to be updated when Core Data is changed.
            mediaArray = try context.fetch(Media.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
    }
    
    // This function is for setting how many rows will be in the table view based on how many entities are in Core Data.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    // Populate each cell with it's respective information.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let media = mediaArray[indexPath.row]
        cell.textLabel?.text = media.title
        cell.imageView?.image = UIImage(data: media.image as! Data)
        return cell
    }

    // These two functions will take the information from Core Data based on the index of the entity and fill the Media View Controller with the appropriate information.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = mediaArray[indexPath.row]
        performSegue(withIdentifier: "mediaSegue", sender: media)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! MediaViewController
        nextVC.media = sender as? Media
    }

}

