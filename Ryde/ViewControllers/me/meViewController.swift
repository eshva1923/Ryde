//
//  meViewController.swift
//  Ryde
//
//  Created by Federico Brandani on 19/07/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit

internal class meViewController: UIViewController {
    override func viewDidLoad() {
        Authentication.shared.displayLogin(onViewController: self);
    }
}
