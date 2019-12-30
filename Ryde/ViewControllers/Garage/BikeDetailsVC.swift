//
//  BikeDetailsVC.swift
//  Ryde
//
//  Created by Federico Brandani on 30/12/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import UIKit
class BikeDetailsVC: UIViewController {
    var thisBike: BikeModel?
    @IBOutlet var detailsTitle: UILabel!
    @IBOutlet var txt_nickname: UITextField!
    @IBOutlet var txt_make: UITextField!
    @IBOutlet var txt_model: UITextField!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    func refresh() {
        if let bike = thisBike {
            detailsTitle.text = "Edit your bike"
            txt_nickname.text = bike.nickname
            txt_make.text = bike.make
            txt_model.text = bike.model
        } else {
            detailsTitle.text = "Register a new bike"
            txt_nickname.text = nil
            txt_make.text = nil
            txt_model.text = nil
        }
    }
}
