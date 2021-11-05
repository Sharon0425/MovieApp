//
//  Photo CollectionViewController.swift
//  MovieApp
//
//  Created by Sharon on 2021/11/5.
//

import UIKit

private let reuseIdentifier = "Cell"

class Photo_CollectionViewController: UICollectionViewController {
    
    
    let photos = (1...1000).map { _ -> Photo in
        let rgb = (1...3).reduce("") { (result, _) in
            result.appending(String(Int.random(in: 0...255),radix: 16,uppercase: true))
        }
        let url = URL(string: "https://via.placeholder.com/200/\(rgb)")!
        
        return Photo(rgb: rgb, url: url)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

  

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! Photo_CollectionViewCell
        
        cell.photo =  photos[indexPath.item]
        cell.update()
    
        // Configure the cell
    
        return cell
    }



}
