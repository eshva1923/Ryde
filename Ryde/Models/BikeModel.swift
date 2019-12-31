//
//  BikeModel.swift
//  Ryde
//
//  Created by Federico Brandani on 30/12/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import Firebase

struct BikeModel: DataModel {
    static var collectionName = "bikes"
    static var imagesCollectionName = "bikesPhotos"

    let photo: String?
    let nickname: String?
    let owner: DocumentReference?
    let comment: String?
    let make: String
    let tags: [String]
    let model: String
    let year: Int
    let info: BikeInfoDetails

    static func mapFromDocument(_ document: [String : Any]) -> BikeModel {
        return BikeModel(photo: document["photo"] as? String,
                          nickname: document["nickname"] as? String,
                          owner: document["owner"] as? DocumentReference,
                          comment: document["comment"] as? String,
                          make: document["make"] as! String,
                          tags: (document["tags"] as! String).components(separatedBy: ","),
                          model: document["model"] as! String,
                          year: document["year"] as! Int,
                          info: BikeInfoDetails.mapFromDocument(document["info"] as! [String : Any]))
    }

    static func test() -> BikeModel {
        return BikeModel(photo: "photo-1550942892-0571f62c613d.jpeg",
                         nickname: "Test Bike",
                         owner: nil,
                         comment: "bike for testing",
                         make: "Harley Davidson",
                         tags: [],
                         model: "XL883N",
                         year: 2014,
                         info: BikeInfoDetails(mileageKm: 1234, oilChangeIntervalKm: 2000, airFilterChangeIntervalKm: 3000, chainLubeIntervalKm: 1000, coolantChangeIntervalKm: 5000, nextServiceKm: 1500, tyresLifeKm: 5000))
    }

    func stringifyInfo() -> String {
        return "\(year) \(make) \(model)"
    }
}

struct BikeInfoDetails {
    let mileageKm: Int
    let oilChangeIntervalKm: Int
    let airFilterChangeIntervalKm: Int
    let chainLubeIntervalKm: Int
    let coolantChangeIntervalKm: Int
    let nextServiceKm: Int
    let tyresLifeKm: Int

    static func mapFromDocument(_ doc: [String: Any]) -> BikeInfoDetails {
        return BikeInfoDetails(mileageKm: doc["mileageKm"] as! Int,
                               oilChangeIntervalKm: doc["oilChangeIntervalKm"] as! Int,
                               airFilterChangeIntervalKm: doc["airFilterChangeIntervalKm"] as! Int,
                               chainLubeIntervalKm: doc["chainLubeIntervalKm"] as! Int,
                               coolantChangeIntervalKm: doc["coolantChangeIntervalKm"] as! Int,
                               nextServiceKm: doc["nextServiceKm"] as! Int,
                               tyresLifeKm: doc["tyresLifeKm"] as! Int)

    }

    func nextMaintenanceKm(_ interval: Int) -> Int {
        guard interval != 0 else { return 0 }
        return mileageKm + interval - mileageKm % interval
    }
    func kmLeftForMaintenance(_ interval: Int) -> Int? {
        guard interval != 0 else {return nil }
        return interval - mileageKm % interval
    }
}
