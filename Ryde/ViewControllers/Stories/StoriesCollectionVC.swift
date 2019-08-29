//
//  StoriesCollectionVC.swift
//  Ryde
//
//  Created by Federico Brandani on 29/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewSlantedLayout

class StoriesCollectionVC: UICollectionViewController {
    var storiesArray: Array<StoryModel> = []
    override func viewDidLoad() {
        let layout = CollectionViewSlantedLayout()
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
        layout.slantingSize = 40
        self.collectionView.collectionViewLayout = layout
        loadStories()
        super.viewDidLoad()
    }
    
    func loadStories() {
        storiesArray.removeAll()
        DataLayer.shared.getAllStories { allStories in
            self.storiesArray = allStories
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryCell
        cell.setupWithModel(storiesArray[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storiesCollectionVC_storyDetailedVC", let destination = segue.destination as? StoryDetailedVC, let selectedStory = (sender as? StoryCell)?.thisModel {
            destination.setStory(selectedStory)
        }
    }
}

class StoryCell: CollectionViewSlantedCell {
    @IBOutlet var img_background:UIImageView!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_underText: UILabel!
    @IBOutlet var lbl_author: UILabel!
    @IBOutlet var lbl_rides: UILabel!
    var thisModel: StoryModel? = nil
    
    func setupWithModel (_ model: StoryModel) {
        thisModel = model
        img_background.sd_setImage(with: model.getCoverImageReference())
        lbl_title.text = model.title
        lbl_underText.text = model.description

        model.getAuthorName { authorName in
            self.lbl_author.text = authorName
        }
        lbl_rides.text = "\(model.rides.count)"
    }
}
