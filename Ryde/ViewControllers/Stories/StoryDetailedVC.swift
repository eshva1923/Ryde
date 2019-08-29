//
//  StoryDetailVC.swift
//  Ryde
//
//  Created by Federico Brandani on 29/08/2019.
//  Copyright © 2019 EshvaSoft. All rights reserved.
//

import Foundation
import UIKit

class StoryDetailedVC: UIViewController {
    private var thisStory: StoryModel?
    @IBOutlet var img_background: UIImageView!
    @IBOutlet var img_cover: UIImageView!
    @IBOutlet var btn_close: UIButton!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_description: UILabel!
    @IBOutlet var lbl_bodyText: UILabel!
    @IBOutlet var lbl_author: UILabel!
    
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
        story.getAuthorName(completionBlock: { authorName in
            self.lbl_author.text = authorName
        })
        //story.likes
        //story.rides
        //story.storyPhotos
        //story.tags
        //story.writtenOn
    }
    @IBAction private func btn_closeDidTap(sender: UIButton!) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
}
