//
//  BreedListTableViewController.swift
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class BreedListTableViewController: UITableViewController {
    
    var breeds = [CVCBreed]() {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CVCBreedsController.fetchBreeds { breeds in
            if let breeds = breeds {
                self.breeds = breeds.sorted { $0.name < $1.name }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)

        let breed = breeds[indexPath.row]
        cell.textLabel?.text = breed.name.capitalized

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let breed = breeds[indexPath.row]
        
        if let subbreeds = breed.subbreeds, subbreeds.count > 0 {
            performSegue(withIdentifier: "breedToSubbreedsVC", sender: self)
        } else {
            performSegue(withIdentifier: "breedToImagesVC", sender: self)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "breedToSubbreedsVC" {
            guard let destinationVC = segue.destination as? SubbreedListTableViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            let breed = breeds[indexPath.row]
            destinationVC.title = breed.name.capitalized
            destinationVC.breed = breed
            
        } else if segue.identifier == "breedToImagesVC" {
            guard let navigationController = segue.destination as? UINavigationController,
                let destinationVC = navigationController.topViewController as? ImagesCollectionViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            let breed = breeds[indexPath.row]
            CVCBreedsController.fetchImageURLs(for: breed) { urls in
                DispatchQueue.main.async {
                    destinationVC.title = breed.name.capitalized
                }
                destinationVC.imageURLs = urls
            }
        }
    }

}
