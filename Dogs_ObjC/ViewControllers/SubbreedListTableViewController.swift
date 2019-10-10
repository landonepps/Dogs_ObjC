//
//  SubbreedListTableViewController.swift
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class SubbreedListTableViewController: UITableViewController {
    
    var breed: CVCBreed? {
        didSet {
            loadViewIfNeeded()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breed?.subbreeds?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subbreedCell", for: indexPath)

        let subbreed = breed?.subbreeds?[indexPath.row]
        cell.textLabel?.text = subbreed?.name

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "subbreedToImagesVC" {
        
            guard let destinationVC = segue.destination as? ImagesCollectionViewController,
                let indexPath = tableView.indexPathForSelectedRow,
                let breed = breed,
                let subbreed = breed.subbreeds?[indexPath.row]
                else { return }

            CVCBreedsController.fetchImageURLs(for: subbreed, breed: breed) { urls in
                destinationVC.imageURLs = urls
            }
        }
    }

}
