//
//  StoryModel.swift
//  Ryde
//
//  Created by Federico Brandani on 26/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import Firebase

struct StoryModel: DataModel {
    
    internal static var collectionName = "stories"
    internal static var imagesCollectionName = "storiesPhotos"

    let coverImage: String
    let title: String
    let author: DocumentReference?
    let description: String
    let bodyText: String
    let tags: [String]
    let rides: [DocumentReference]
    let likes: Int
    let writtenOn: Timestamp
    let storyPhotos: [String]

    static func test() -> StoryModel {
        return StoryModel(coverImage: "NONE",
                          title: "Test Story",
                          author: nil,
                          description: "This is a test story",
                          bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit scelerisque nibh, vulputate cursus nisi dapibus vitae. Etiam fringilla, velit vitae lacinia feugiat, nisl velit consectetur quam, vitae tristique augue lacus et purus. In id nisl sed turpis malesuada placerat. Curabitur venenatis augue in tincidunt elementum. Aliquam cursus luctus magna a dignissim. Donec vel libero at lorem porta efficitur ut non velit. Mauris malesuada, erat ut lobortis commodo, massa tortor pharetra arcu, non efficitur quam arcu at enim. Ut sed rhoncus odio. Proin nec dignissim sem, a dictum lacus. Ut aliquam mollis aliquet. Pellentesque mauris arcu, tristique id nulla vitae, sodales feugiat elit. Ut condimentum, neque ac dignissim faucibus, tortor ligula pharetra ante, egestas dignissim augue ex id diam. Quisque dictum sapien condimentum velit efficitur tempus. Duis nisi magna, imperdiet sed pulvinar ac, consectetur et leo. Nam cursus feugiat sem ac condimentum. Aenean eu ultricies purus. Suspendisse potenti. Phasellus at interdum ligula. Vivamus a eros malesuada, gravida magna et, congue augue. Suspendisse gravida augue vitae finibus scelerisque. Suspendisse eget dui magna. Etiam commodo nunc vitae lacus sagittis ornare. Nulla viverra vulputate erat. Praesent erat dolor, euismod ut lorem id, imperdiet luctus magna. Mauris sit amet suscipit ipsum. Aenean interdum diam id elit sollicitudin bibendum. Aliquam odio nisl, efficitur at arcu eu, fringilla ultricies nisl. Fusce scelerisque interdum tellus at tristique. Suspendisse porttitor ullamcorper augue. Curabitur sed malesuada libero, sed laoreet quam. Phasellus semper nisl non lorem elementum, ac lobortis quam vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent eu semper risus, at imperdiet lectus.",
                          tags: ["Story", "test", "blessed", "yolo"],
                          rides: [],
                          likes: 6,
                          writtenOn: Timestamp(date: Date()),
                          storyPhotos: [])
    }
    
    static func mapFromDocument(_ document: [String : Any]) -> StoryModel {
        return StoryModel(coverImage: document["coverImage"] as! String,
                          title: document["title"] as! String,
                          author: document["author"] as? DocumentReference,
                          description: document["description"] as! String,
                          bodyText: document["bodyText"] as! String,
                          tags: (document["tags"] as! String).components(separatedBy: ","),
                          rides: document["rides"] as! Array<DocumentReference>,
                          likes: document["likes"] as! Int,
                          writtenOn: document["writtenOn"] as! Timestamp,
                          storyPhotos: document["storyPhotos"] as! Array<String>
        )
    }
}
