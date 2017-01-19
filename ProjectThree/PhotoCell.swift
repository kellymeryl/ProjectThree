//
//  PhotoCell.swift
//  ProjectThree
//
//  Created by Benjamin Landau on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
    
    func didTap(_ sender: UITapGestureRecognizer) {
        
        if imageOutlet == nil { return }
        
    }
    
}
