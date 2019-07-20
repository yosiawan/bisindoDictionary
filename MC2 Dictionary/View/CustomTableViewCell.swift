//
//  CustomTableViewCell.swift
//  scrollView
//
//  Created by wimba prasiddha on 15/07/19.
//  Copyright © 2019 wimba prasiddha. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var topikLabel: UILabel!
    @IBOutlet weak var topikImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
