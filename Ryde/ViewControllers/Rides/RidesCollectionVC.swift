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

class RidesCollectionVC: UICollectionViewController {
    override func viewDidLoad() {
        let layout = CollectionViewSlantedLayout()
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
        layout.slantingSize = 40
        self.collectionView.collectionViewLayout = layout
        super.viewDidLoad()

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rideCollectionCell", for: indexPath) as! RideCollectionCell
        cell.setupWithModel(RideModel.test())
        return cell
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
        } else {
            //default here
            img_background.image = UIImage(imageLiteralResourceName: "sylvain-sarrailh-cricketstory")
        }
        lbl_km.text = "\(rideModel.lenght) Km"
        lbl_title.text = rideModel.title
        lbl_author.text = rideModel.author
        lbl_difficulty.text = String(repeating: "✪ ", count: rideModel.difficulty)
        lbl_composition.text = rideModel.composition.stringify()
        lbl_tags.text = rideModel.tags?.joined(separator: ", ")
        lbl_country.text = rideModel.country.split(separator: "/").compactMap { Countries.getCountry(String($0))}.map { "\($0.flag) \($0.code2)"}.joined(separator: " / ")
        lbl_likes.text = "\(rideModel.likes)"
        lbl_done.text = "\(rideModel.done)"

    }

}
