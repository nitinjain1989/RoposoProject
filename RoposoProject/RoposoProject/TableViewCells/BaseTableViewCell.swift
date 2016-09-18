//
//  BaseTableViewCell.swift
//  RoposoProject
//
//  Created by Nitin Jain on 18/09/16.
//  Copyright © 2016 Nitin Jain. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCellData(data:StoryData) -> Void
    {
        
    }
}
