//
//  StoryDetailVC.swift
//  Ryde
//
//  Created by Federico Brandani on 29/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class StoryDetailedVC: UIViewController {
    
    private var thisStory: StoryModel?
    @IBOutlet var img_background: UIImageView!
    @IBOutlet var img_cover: UIImageView!
    @IBOutlet var btn_close: UIButton!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_description: UILabel!
    @IBOutlet var lbl_bodyText: UILabel!
    @IBOutlet var lbl_author: UILabel!
    @IBOutlet var cv_collectionView: UICollectionView!
    private var selectedImageReference: StorageReference!
    
    private var otherPhotos:[StorageReference] = []
    
    internal func setStory(_ story: StoryModel) {
        thisStory = story
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        super.viewWillAppear(animated)
    }
    
    private func setup() {
        guard let story = thisStory else {return}
        img_background.sd_setImage(with: story.getCoverImageReference())
        img_cover.sd_setImage(with: story.getCoverImageReference())
        lbl_title.text = story.title
        lbl_bodyText.text = story.bodyText
        lbl_description.text = story.description
        story.getAuthorName(completionBlock: { authorName in
            let elapsedTime = DateHelper.elapsedFuzzyTime(from: story.writtenOn.dateValue())
            let author = (authorName != nil) ? authorName! : "someone"
            self.lbl_author.text = "written by \(author) \(elapsedTime)"
        })
        selectedImageReference = story.getCoverImageReference()
        otherPhotos = story.getOtherImagesReferences()
        cv_collectionView.reloadData()
        
        //story.likes
        //story.rides
        //story.storyPhotos
        //story.tags
        
    }
    @IBAction private func btn_closeDidTap(sender: UIButton!) {
        self.dismiss(animated: true)
    }
}

extension StoryDetailedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + otherPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyPhotosCell", for: indexPath) as! StoryPhotoCell
        
        if indexPath.row == 0 {
            cell.img_photo.sd_setImage(with: thisStory!.getCoverImageReference())
        } else {
            cell.img_photo.sd_setImage(with: otherPhotos[indexPath.row - 1 ])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = indexPath.row == 0 ? thisStory!.getCoverImageReference() : otherPhotos[indexPath.row - 1]
        selectedImageReference = selectedImage
        img_cover.sd_setImage(with: selectedImageReference)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storyDetail_popupImage", let popupImage = segue.destination as? PopupImageViewController {
            popupImage.imageReference = selectedImageReference
        }
    }
}

class StoryPhotoCell: UICollectionViewCell {
    @IBOutlet var img_photo: UIImageView!
}
