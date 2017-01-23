//
//  ColorCell.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/23/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {
   
   @IBOutlet weak var itemColor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
