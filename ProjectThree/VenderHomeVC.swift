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
    
    var vendorsItems = [DataModel.sharedInstance.item] {
        didSet {
            collectionViewOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("==============I just loaded!==============")

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirebaseModel.sharedInstance.observeItems(success: { [weak self] items in
            guard let strongSelf = self else {return}
            strongSelf.vendorsItems = items
        })
    }
    
//MARK: @IBOUTLETS================================================
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
 //MARK: CollectionView Methods and Properties====================
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vendorsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell1", for: indexPath) as! ItemCell
//        if tempVenID == (vendorsItems[indexPath.item]?.vendor) {
//            cell.homeLblOutlet.text = vendorsItems[indexPath.item]?.name
//            return cell
//        } else {
//            return UICollectionViewCell()
//        }
            return cell
    }
    
}
