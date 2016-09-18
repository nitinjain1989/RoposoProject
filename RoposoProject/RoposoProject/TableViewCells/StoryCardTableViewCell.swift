//
//  StoryCardTableViewCell.swift
//  RoposoProject
//
//  Created by Nitin Jain on 18/09/16.
//  Copyright © 2016 Nitin Jain. All rights reserved.
//

import UIKit
import SDWebImage

protocol StoryCardCellDelegate
{
    func followUnFollow();
}

class StoryCardTableViewCell: BaseTableViewCell
{
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    var data:StoryData!
    var delegate:StoryCardCellDelegate!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        storyImageView.clipsToBounds = true
        followButton.layer.cornerRadius = 15
        followButton.layer.borderColor = UIColor.black.cgColor
        followButton.layer.borderWidth = 0.5
        followButton.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setUpCellData(data:StoryData)
    {
        userImageView.sd_setImage(with: NSURL(string: data.userData.imageUrl!) as URL!)
        userNamelabel.text = data.userData.userName!
        
        storyImageView.sd_setImage(with: NSURL(string: data.storyImageUrl!)! as URL!)
        
        followButton.isSelected = false
        if data.userData.isFollow!
        {
            followButton.isSelected = true
        }
        
        self.data = data
    }
    
    @IBAction func followButtonPressed(_ sender: UIButton)
    {
        if data.userData.isFollow!
        {
            data.userData.isFollow! = false
        }
        else
        {
            data.userData.isFollow! = true
        }
        delegate.followUnFollow()
    }
    
}
