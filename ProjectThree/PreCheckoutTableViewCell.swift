//
//  PreCheckoutTableViewCell.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/18/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class PreCheckoutTableViewCell: UITableViewCell {
   
   @IBOutlet weak var itemImage: UIImageView!
   @IBOutlet weak var itemName: UILabel!
   @IBOutlet weak var itemPrice: UILabel!
   @IBOutlet weak var itemQuantity: UILabel!
   
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
