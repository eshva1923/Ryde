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
    static var imagesCollectionName: String { get }
    static func mapFromDocument(_ document: [String: Any]) -> Self
    static func test() -> Self
}

class DataLayer {
    static let shared = DataLayer()
    private let db = Firestore.firestore()
    
    private func getAllDocuments(ofType type: DataModel.Type, offset: UInt = 0, limit: UInt = 0, completionBlock: @escaping ([DataModel]) -> Void, errorBlock: @escaping () -> Void) {
        db.collection(type.collectionName).getDocuments { (querySnapshot, error) in
            guard error == nil else {
                print("Error getting docs! \(error!.localizedDescription)")
                errorBlock()
                return
            }
            guard let snapshot = querySnapshot else { completionBlock([]); return }
            var returning:[DataModel] = []
            for document in snapshot.documents {
                returning.append(type.mapFromDocument(document.data()))
            }
            completionBlock(returning)
        }
    }
    
    private func getDocumentsBy(reference: DocumentReference, ofType type: DataModel.Type, completionBlock: @escaping (DataModel?) -> Void) {
        reference.getDocument { (document, error) in
            guard error == nil else { print("oh shit \(error!.localizedDescription)"); completionBlock(nil); return}
            if let document = document, document.exists {
                completionBlock(type.mapFromDocument(document.data()!))
            }
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
extension StoryModel {
    func loadRides(completionBlock:@escaping (RideModel?)->Void) {
        for ride in rides {
            DataLayer.shared.getRideBy(reference: ride, completionBlock: completionBlock)
        }
    }
    func getAuthorName(completionBlock: @escaping (String?)->Void) {
        author!.getDocument { (document, error) in
            guard error == nil, let doc = document, doc.exists else { return }
            completionBlock(doc.data()! ["displayName"] as? String)
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
    func getRideBy(reference: DocumentReference, completionBlock: @escaping ((RideModel?) -> Void)) {
        getDocumentsBy(reference: reference, ofType: RideModel.self, completionBlock: completionBlock as! (DataModel?) -> Void)
    }
}
