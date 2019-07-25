//
//  meViewController.swift
//  Ryde
//
//  Created by Federico Brandani on 19/07/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

internal class meViewController: UIViewController {
    @IBOutlet var lbl_userName: UILabel!
    @IBOutlet var lbl_userQuote: UILabel!
    @IBOutlet var lbl_userRoad: UILabel!
    @IBOutlet var lbl_userRank: UILabel!
    @IBOutlet var lbl_userLikes: UILabel!
    @IBOutlet var img_userPhoto: UIImageView!

    private var currentUser: User?
    override func viewDidLoad() {
        Authentication.shared.registerCallbackForAuthorizationStateChange { (auth, user) in self.currentUser = user; self.setupMe() }
    }
    override func viewWillAppear(_ animated: Bool) {
        currentUser = Authentication.shared.getCurrentUser()
        if currentUser == nil {
            Authentication.shared.displayLogin(onViewController: self)
        } else {
            setupMe()
        }
        super.viewWillAppear(animated)
    }

    private func setupMe() {
        guard let user = currentUser else {return}
        lbl_userName.text = user.displayName
        lbl_userRank.text =
        user.email
        user.photoURL
    }

    @IBAction private func act_logoutBtnDidTap(sender: UIButton) {
        Authentication.shared.logout()
    }
}
