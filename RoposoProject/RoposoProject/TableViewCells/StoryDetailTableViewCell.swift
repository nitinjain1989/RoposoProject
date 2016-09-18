//
//  StoryDetailTableViewCell.swift
//  RoposoProject
//
//  Created by Nitin Jain on 18/09/16.
//  Copyright © 2016 Nitin Jain. All rights reserved.
//

import UIKit

class StoryDetailTableViewCell: BaseTableViewCell
{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setUpCellData(data:StoryData) -> Void
    {
        titleLabel.text = data.storyTitle!
        descriptionLabel.text = data.storyDescription!
    }
    
}
