//
//  ImagesCollectionViewController.swift
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

private let reuseIdentifier = "imageCell"

class ImagesCollectionViewController: UICollectionViewController {
    
    var imageURLs: [URL]? {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell
            else {
                fatalError("Unable to cast cell with reuse identifier: \(reuseIdentifier) as ImageCollectionViewCell")
        }
    
        cell.imageView.image = nil
        
        if let imageURL = imageURLs?[indexPath.row] {
            CVCBreedsController.fetchImage(for: imageURL) { image in
                guard let image = image
                    else { return }
                
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
    
        return cell
    }
}
