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
   var allItems = [DataModel.sharedInstance.item]
    
    
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
         print(strongSelf.allItems)
         for item in strongSelf.allItems {
            print(item)
         }
         })
      
      
   }
    
//MARK: @IBOUTLETS================================================
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
 //MARK: CollectionView Methods and Properties====================
    
    var homeScreenPhotos = [UIImage]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeScreenPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! ItemCell
        
        cell.homeImageOutlet.image = homeScreenPhotos[indexPath.row]
        
        return cell
    }
}
