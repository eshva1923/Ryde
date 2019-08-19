//
//  RideModel.swift
//  Ryde
//
//  Created by Federico Brandani on 19/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation

struct RideModel {
    let image: String?
    let title: String
    let author: String
    let country: String
    let lenght: Double
    let difficulty: Int
    let composition: RoadComposition
    let tags: [String]?
    let done: Int
    let likes: Int

    static func test() -> RideModel{
        return RideModel(image: nil,
                         title: "Test Ride",
                         author: "testAuthor",
                         country: "🇫🇷/IT",
                         lenght: 450.45,
                         difficulty: 3,
                         composition: RoadComposition(street: 50,
                                                      motorway: 25,
                                                      dirt: 10,
                                                      sand: 0,
                                                      rocks: 0),
                         tags: ["Mountain", "Alps", "Summer"],
                         done: 3,
                         likes: 7)
    }
}

struct RoadComposition {
    let street : Int
    let motorway: Int
    let dirt: Int
    let sand: Int
    let rocks: Int

    func stringify() -> String {
        var returnArray:[String] = []
        if street > 0 {
            returnArray.append("Str: \(street)%")
        }
        if motorway > 0 {
            returnArray.append("Hwy: \(motorway)%")
        }
        if dirt > 0 {
            returnArray.append("Dirt: \(dirt)%")
        }
        if sand > 0 {
            returnArray.append("Sand: \(sand)%")
        }
        if rocks > 0 {
            returnArray.append("Rocks: \(rocks)%")
        }
        return returnArray.joined(separator: " ")
    }
}
