//
//  PopupImageViewController.swift
//  Ryde
//
//  Created by Federico Brandani on 29/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import UIKit
import Firebase

class PopupImageViewController: UIViewController {
    @IBOutlet var img_mainImage: UIImageView!
    @IBOutlet var img_backImage: UIImageView!
    
    var imageReference: StorageReference!
    
    override func viewWillAppear(_ animated: Bool) {
        img_backImage.sd_setImage(with: imageReference)
        img_mainImage.sd_setImage(with: imageReference)
        super.viewWillAppear(animated)
    }
    
    @IBAction func btn_closeDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
