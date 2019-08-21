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
            if let image = ride.imageURL {
                img_image.sd_setImage(with: URL(string: image), completed: nil)
            }
            lbl_title.text = ride.title
            lbl_description.text = ride.description
            lbl_author.text = ride.author
            lbl_country.text = Countries.stringifyRideCountries(ride, mode: .code3, withFlag: true)
            lbl_lenght.text = "\(ride.lenght) Km"
            lbl_tags.text = ride.tags?.joined(separator: ", ")
            lbl_composition.text = ride.composition.stringify()
            lbl_difficulty.text = ride.stringifyDifficulty()
            collectionView.isHidden = (ride.photosURL == nil)
            collectionView.reloadData()
        }
    }
}

extension RideDetailedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        guard let ride = thisRide else { return count }
        if ride.imageURL != nil {
            count = 1
        }
        return ride.photosURL != nil ? count + ride.photosURL!.count : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RidePhotoCell", for: indexPath) as! RidePhotoCell
        guard let ride = thisRide else { return cell }
        var indexPathRow = indexPath.row
        if let mainImage = ride.imageURL {
            if indexPathRow == 0 {
                cell.img_photoView.sd_setImage(with: URL(string: mainImage)!, completed: nil)
                return cell
            } else {
                indexPathRow = indexPathRow - 1
            }
        }
        
        if ride.photosURL != nil {
            cell.img_photoView.sd_setImage(with: URL(string: ride.photosURL![indexPathRow]), completed: nil)
        }
        
        return cell
    }
}

class RidePhotoCell: UICollectionViewCell {
    @IBOutlet var img_photoView: UIImageView!
}
