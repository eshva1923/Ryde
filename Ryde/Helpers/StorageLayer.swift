//
//  StorageLayer.swift
//  Ryde
//
//  Created by Federico Brandani on 28/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import Firebase

class StorageLayer {
    static let shared = StorageLayer()
    private static let store = Storage.storage()
    
    private func collection(forModel model: DataModel.Type) -> StorageReference {
        return StorageLayer.store.reference(withPath: model.imagesCollectionName)
    }
    
    fileprivate func imageReference(name: String, forModel model: DataModel.Type) -> StorageReference {
        return collection(forModel: model).child(name)
    }
}

//rides
extension RideModel {
    internal func getCoverImageReference() -> StorageReference? {
        return coverImage != nil ? StorageLayer.shared.imageReference(name: coverImage!, forModel: RideModel.self) : nil
    }
    internal func getPhotosReferences() -> [StorageReference] {
        var ret:[StorageReference] = []
        
        for img in otherImages {
            ret.append(StorageLayer.shared.imageReference(name: img, forModel: RideModel.self))
        }
        return ret
    }
}

//stories
extension StoryModel {
    internal func getCoverImageReference() -> StorageReference {
        return StorageLayer.shared.imageReference(name: coverImage, forModel: StoryModel.self)
    }
    internal func getOtherImagesReferences() -> [StorageReference] {
        var ret: [StorageReference] = []
        
        for img in storyPhotos {
            ret.append(StorageLayer.shared.imageReference(name: img, forModel: StoryModel.self))
        }
        return ret
    }
    
}
