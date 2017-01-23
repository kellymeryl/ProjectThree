//
//  VenderHomeVC.swift
//  ProjectThree
//
//  Created by Benjamin Landau on 1/17/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class VenderHomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   
    var userID = ""
   var allItems = [DataModel.sharedInstance.item] {
      didSet {
         allItemsCollection.reloadData()
      }
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
   
   override func viewDidAppear(_ animated: Bool) {
      

      
      FirebaseModel.sharedInstance.observeItems(success: { [weak self] items in
            guard let strongSelf = self else {return}
            strongSelf.allItems = items
         })
      
      
   }
    
//MARK: @IBOUTLETS================================================

   @IBOutlet weak var allItemsCollection: UICollectionView!
   
   
 //MARK: CollectionView Methods and Properties====================
    
    var homeScreenPhotos = [UIImage]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItems.count
    }
   

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell1", for: indexPath) as! ItemCell
      
      cell.itemName.text = allItems[indexPath.item]?.name
      if let price = allItems[indexPath.item]?.price {
         cell.itemPrice.text = "\(convertToCurrency(num: price))"
      }
//      cell.itemImageView.image = allItems[indexPath.item]?.image
        return cell
    }
   
   
   
   func convertToCurrency(num: String) -> String {
      
      let number = NSDecimalNumber(value: Float(num)!)
      
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .currency
      
      let result = numberFormatter.string(from: number)
      
      return result!
   }
   
   
}
