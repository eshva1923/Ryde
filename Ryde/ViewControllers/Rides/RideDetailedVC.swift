//
//  RideDetailedVC.swift
//  Ryde
//
//  Created by Federico Brandani on 20/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit

class RideDetailedVC: UIViewController {
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_description: UILabel!
    @IBOutlet var img_image: UIImageView!
    @IBOutlet var lbl_author: UILabel!
    @IBOutlet var lbl_country: UILabel!
    @IBOutlet var lbl_lenght: UILabel!
    @IBOutlet var lbl_difficulty: UILabel!
    @IBOutlet var lbl_tags: UILabel!
    @IBOutlet var lbl_composition: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    /*let composition: RoadComposition
    let tags: [String]?
    let done: Int
    let likes: Int
    let description: String
*/
    private var thisRide: RideModel? = nil

    func setRide(_ ride: RideModel) {
        thisRide = ride
    }
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        updateView()
    }
    private func updateView() {
        if let ride = thisRide {
            if let image = ride.image {
                img_image.image = UIImage(imageLiteralResourceName: image)
            }
            lbl_title.text = ride.title
            lbl_description.text = ride.description
            lbl_author.text = ride.author
            lbl_country.text = Countries.stringifyRideCountries(ride)
            lbl_lenght.text = "\(ride.lenght) Km"
            lbl_tags.text = ride.tags?.joined(separator: ", ")
            lbl_composition.text = ride.composition.stringify()
            collectionView.isHidden = (ride.photosURL == nil)
            collectionView.reloadData()
        }
    }
}

extension RideDetailedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let ride = thisRide, ride.photosURL != nil{
            return ride.photosURL!.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RidePhotoCell", for: indexPath) as! RidePhotoCell
        if let ride = thisRide, ride.photosURL != nil {
            cell.img_photoView.image = UIImage(imageLiteralResourceName: ride.photosURL![indexPath.row])
        }
        return cell
    }
}

class RidePhotoCell: UICollectionViewCell {
    @IBOutlet var img_photoView: UIImageView!
}
