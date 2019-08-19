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
    }

    internal func registerCallbackForAuthorizationStateChange(callback: @escaping AuthStateDidChangeListenerBlock) {
        Auth.auth().addStateDidChangeListener(callback)
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
        if let err = error, err.localizedDescription.contains("error 1") {
            userCanceled()
            return
        }
        print(authDataResult);
    }
    internal func userCanceled() {
        print("user canceled login")
    }
    internal func logout() {
        try! ui.signOut()
    }


}

extension Authentication {
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    func getAdditionalInfoForUser(user: User? = Auth.auth().currentUser ) -> Any? { //Dictionary? {
        guard let thisUser = user else { return nil }
        return nil
    }


}
