//
//  DataLayer.swift
//  Ryde
//
//  Created by Federico Brandani on 20/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import Firebase

protocol DataModel {
    static var collectionName: String { get }
    static func mapFromDocument(_ document: [String: Any]) -> Self
    static func test() -> Self
}

class DataLayer {
    static let shared = DataLayer()
    private let db = Firestore.firestore()
    
    func getAllRides(offset: Int = 0 , limit: Int = 0, callback: @escaping ([RideModel]) -> Void, errorBlock: @escaping ()->Void ) {
        db.collection(RideModel.collectionName).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                errorBlock()
            } else {
                var returningRides:[RideModel] = []
                for document in querySnapshot!.documents {
                    returningRides.append(RideModel.mapFromDocument(document.data()))
                    //print("\(document.documentID) => \(document.data())")
                }
                callback(returningRides)
            }
        }
    }
}
