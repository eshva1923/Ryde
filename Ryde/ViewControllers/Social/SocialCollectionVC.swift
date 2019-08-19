//
//  SocialCollectionVC.swift
//  Ryde
//
//  Created by Federico Brandani on 19/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewSlantedLayout

class SocialCollectionVC: UICollectionViewController {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialContactCell", for: indexPath) as! SocialContactCell
        cell.img_background.image = UIImage(imageLiteralResourceName: "sylvain-sarrailh-cricketstory")
        cell.lbl_title.text = "TITLE cell \(indexPath.row)"
        cell.lbl_underText.text = "SUBTITLE cell \(indexPath.row)"
        return cell
    }
}

class SocialContactCell: CollectionViewSlantedCell {
    @IBOutlet var img_background:UIImageView!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_underText: UILabel!
}
