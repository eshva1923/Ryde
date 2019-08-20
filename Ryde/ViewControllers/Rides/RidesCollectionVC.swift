//
//  RidesCollectionVC.swift
//  Ryde
//
//  Created by Federico Brandani on 19/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewSlantedLayout
import SPStorkController

class RidesCollectionVC: UICollectionViewController {
    var ridesArray: Array<RideModel> = []
    override func viewDidLoad() {
        let layout = CollectionViewSlantedLayout()
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
        layout.slantingSize = 40
        loadRides()
        self.collectionView.collectionViewLayout = layout
        super.viewDidLoad()
    }
    private func loadRides() {
        ridesArray.removeAll()
        //TESTING---
        for _ in 0..<10 {
            ridesArray.append(RideModel.test())
        }
        //---
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ridesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rideCollectionCell", for: indexPath) as! RideCollectionCell
        cell.setupWithModel(ridesArray[indexPath.row])
        return cell
    }
}

extension RidesCollectionVC {

    private func openAsStork(_ vc: RideDetailedVC) {
        let transitionDelegate = SPStorkTransitioningDelegate()
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        transitionDelegate.customHeight = UIScreen.main.bounds.height*0.75

        self.present(vc, animated: true, completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc: RideDetailedVC = storyboard?.instantiateViewController(withIdentifier: "RidesDetailed") as? RideDetailedVC {
            vc.setRide(ridesArray[indexPath.row])
            openAsStork(vc)
        }
    }

}

class RideCollectionCell: CollectionViewSlantedCell {
    @IBOutlet var img_background: UIImageView!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_author: UILabel!
    @IBOutlet var lbl_country: UILabel!
    @IBOutlet var lbl_difficulty: UILabel!
    @IBOutlet var lbl_km: UILabel!
    @IBOutlet var lbl_composition: UILabel!
    @IBOutlet var lbl_tags: UILabel!
    @IBOutlet var lbl_done: UILabel!
    @IBOutlet var lbl_likes: UILabel!

    func setupWithModel(_ rideModel: RideModel) {
        if let image = rideModel.image {
            img_background.image = UIImage(imageLiteralResourceName: image)
        }

        lbl_km.text = "\(rideModel.lenght) Km"
        lbl_title.text = rideModel.title
        lbl_author.text = rideModel.author
        lbl_difficulty.text = rideModel.stringifyDifficulty()
        lbl_composition.text = rideModel.composition.stringify()
        lbl_tags.text = rideModel.tags?.joined(separator: ", ")
        lbl_country.text = Countries.stringifyRideCountries(rideModel)
        lbl_likes.text = "\(rideModel.likes)"
        lbl_done.text = "\(rideModel.done)"
    }

}
