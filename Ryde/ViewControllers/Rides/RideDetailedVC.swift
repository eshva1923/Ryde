//
//  RideDetailedVC.swift
//  Ryde
//
//  Created by Federico Brandani on 20/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit
import Firebase

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
    private var otherImagesRef:[StorageReference] = []

    func setRide(_ ride: RideModel) {
        thisRide = ride
        otherImagesRef = thisRide!.getPhotosReferences()
    }
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        updateView()
    }
    private func updateView() {
        if let ride = thisRide {
            if ride.coverImage != nil {
                img_image.sd_setImage(with: ride.getCoverImageReference()!)
            }
            lbl_title.text = ride.title
            lbl_description.text = ride.description
            lbl_author.text = ride.author
            lbl_country.text = Countries.stringifyRideCountries(ride, mode: .code3, withFlag: true)
            lbl_lenght.text = "\(ride.lenght) Km"
            lbl_tags.text = ride.tags.joined(separator: ", ")
            lbl_composition.text = ride.composition.stringify()
            lbl_difficulty.text = ride.stringifyDifficulty()
            collectionView.isHidden = ride.otherImages.count == 0
            collectionView.reloadData()
        }
    }
}

extension RideDetailedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        guard let ride = thisRide else { return count }
        if ride.coverImage != nil {
            count = 1
        }
        return otherImagesRef.count != 0 ? count + otherImagesRef.count : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RidePhotoCell", for: indexPath) as! RidePhotoCell
        guard let ride = thisRide else { return cell }
        var indexPathRow = indexPath.row
        if ride.coverImage != nil {
            if indexPathRow == 0 {
                cell.img_photoView.sd_setImage(with: ride.getCoverImageReference()!)
                return cell
            } else {
                indexPathRow = indexPathRow - 1
            }
        }
        
        cell.img_photoView.sd_setImage(with: self.otherImagesRef[indexPathRow])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageRef = indexPath.row == 0 ? thisRide?.getCoverImageReference() : otherImagesRef[indexPath.row - 1]
        performSegue(withIdentifier: "rideDetail_popupImage", sender: selectedImageRef)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rideDetail_popupImage", let destination = segue.destination as? PopupImageViewController, let selectedImageReference = sender as? StorageReference {
            destination.imageReference = selectedImageReference
        }
    }
}

class RidePhotoCell: UICollectionViewCell {
    @IBOutlet var img_photoView: UIImageView!
}
