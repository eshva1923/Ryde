//
//  Authentication.swift
//  Ryde
//
//  Created by Federico Brandani on 19/07/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import FirebaseUI

internal class Authentication: NSObject, FUIAuthDelegate {

    static let shared = Authentication()

    private let ui = FUIAuth.defaultAuthUI()!
    private let providers: [FUIAuthProvider] = [
        FUIGoogleAuth(),
        //FUIFacebookAuth(),
        //FUITwitterAuth(),
        //FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()),
    ]

    private override init() {
        super.init()
        ui.delegate = self
        ui.providers = providers
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print (self.getCurrentUser())
        }
    }

    internal func handleURL(url: URL, source: String?) -> Bool {
        return ui.handleOpen(url, sourceApplication: source)
    }

    internal func displayLogin(onViewController parentVC: UIViewController) {
        parentVC.present(ui.authViewController(), animated: true) {
            //completed
        }
    }

    internal func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print(authDataResult);
    }

}

extension Authentication {
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }

}
