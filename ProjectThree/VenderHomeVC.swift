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

class VenderHomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var tempVenID = "test123"
   
   var allItemsFromVendor = [DataModel.sharedInstance.item] {
        didSet {
            collectionViewOutlet.reloadData()
        }
    }
   
   var imagesForItems = [UIImage]()
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("==============I just loaded!==============")

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    override func viewDidAppear(_ animated: Bool) {
      FirebaseModel.sharedInstance.queryItems(searchPath: "item", key: "vendor", valueToSearch: "z7oLKBBeBGb0HScKrRkpIthhv9N2", success: { [weak self] arrayOfItems in
         guard let strongSelf = self else {return}
         strongSelf.allItemsFromVendor = arrayOfItems
         
         
         for item in arrayOfItems {
            for (index, imageURL) in item.imageURLs.enumerated() {
               FirebaseModel.sharedInstance.downloadImage(name: imageURL, complete: { image in
                  print(image!)
                  self?.imagesForItems.append(image!)
                  
                  if index == arrayOfItems.count {
                     
                     self?.collectionViewOutlet.reloadData()
                  }
                  
               })
            }
         }
      })
    }
    
//MARK: @IBOUTLETS================================================
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
 //MARK: CollectionView Methods and Properties====================
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItemsFromVendor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell1", for: indexPath) as! ItemCell
      cell.itemName.text = self.allItemsFromVendor[indexPath.item]?.name
      
      cell.itemImageURL = self.allItemsFromVendor[indexPath.item]?.imageURLs[0]
      return cell


      }
   }
