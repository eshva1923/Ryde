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
    
    func getAllDocuments(ofType type: DataModel.Type, offset: UInt = 0, limit: UInt = 0, completionBlock: @escaping ([DataModel]) -> Void, errorBlock: @escaping () -> Void) {
        db.collection(type.collectionName).getDocuments { (querySnapshot, error) in
            guard error == nil else {
                print("Error getting docs! \(error!.localizedDescription)")
                errorBlock()
                return
            }
            //var returning:[type.self] = []
            guard let snapshot = querySnapshot else { completionBlock([]); return }
            var returning:[DataModel] = []
            for document in snapshot.documents {
                returning.append(type.mapFromDocument(document.data()))
            }
            completionBlock(returning)
            
        }
    }
}
//stories
extension DataLayer {
    func getAllStories(offset: UInt = 0, limit: UInt = 0, completionBlock: @escaping ([StoryModel]) -> Void) {
        getAllDocuments(ofType: StoryModel.self, offset: offset, limit: limit, completionBlock: { stories in
            guard let allStories = stories as? [StoryModel] else {print("error!"); return}
            completionBlock(allStories)
        }) {
            ////
        }
    }
}

//rides
extension DataLayer {
    func getAllRides(offset: UInt = 0, limit: UInt = 0, completionBlock: @escaping ([RideModel]) -> Void) {
        getAllDocuments(ofType: RideModel.self, offset: offset, limit: limit, completionBlock: { rides in
            guard let allRides = rides as? [RideModel] else { print("error!"); return }
            completionBlock(allRides)
        }) {
            ////
        }
    }
}
