//
//  ItemCell.swift
//  ProjectThree
//
//  Created by Benjamin Landau on 1/19/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
   @IBOutlet weak var itemImage: UIImageView!
   @IBOutlet weak var itemName: UILabel!
   
   var itemImageURL: String? {
      didSet {
         itemImage.setImageWithURL(urlString: itemImageURL)
      }
   }
   
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
    
    func didTap(_ sender: UITapGestureRecognizer) {
    
      // let tappedImageView = gestureRecognizers(
       // tappedImageView.
        
    }
}
