//
//  ReviewCellTableViewCell.swift
//  Movies
//
//  Created by Sara Alaa on 3/17/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class ReviewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var contentText: UILabel!
    @IBOutlet weak var authorText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
