//
//  ShoppingCartCellTableViewCell.swift
//  ProjectThree
//
//  Created by Andrew Moskowitz on 1/15/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class ShoppingCartCellTableViewCell: UITableViewCell {

    @IBOutlet weak var itemCartThumbnail: UIImageView!
    
    @IBOutlet weak var itemNameCart: UILabel!
    
    @IBOutlet weak var itemQuantityCart: UILabel!
    
    @IBOutlet weak var itemPriceCart: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
