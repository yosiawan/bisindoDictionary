//
//  TopikTableViewCell.swift
//  MC2 Dictionary
//
//  Created by wimba prasiddha on 18/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class TopikTableViewCell: UITableViewCell {

    @IBOutlet weak var sentenceLabel: UILabel!
    public var selectedSentenceKeys: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
