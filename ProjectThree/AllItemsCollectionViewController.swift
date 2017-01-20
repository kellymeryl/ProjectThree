//
//  AllItemsCollectionViewController.swift
//  ProjectThree
//
//  Created by Andrew Moskowitz on 1/16/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit
import Firebase


class AllItemsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var allItemsCollection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
   
   var selectedItem: Int?
    
    var allItems = [DataModel.sharedInstance.item] {
        didSet {
            allItemsCollection.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allItems.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! AllItemsCollectionViewCell
        
        cell.itemNameLabel.text = allItems[indexPath.item]?.name
        if let price = allItems[indexPath.item]?.price {
            cell.itemPriceLabel.text = "\(convertToCurrency(num: price))"
        }
        return cell
    }
    
    func convertToCurrency(num: String) -> String {
        
        let number = NSDecimalNumber(value: Float(num)!)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        let result = numberFormatter.string(from: number)
        
        return result!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemDetailViewController = segue.destination as! ItemDetailViewController
        itemDetailViewController.selectedIndex = allItemsCollection.indexPathsForSelectedItems?.first?.item
      itemDetailViewController.selectedItem = allItems[(allItemsCollection.indexPathsForSelectedItems?.first?.item)!]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirebaseModel.sharedInstance.observeItems(success: { [weak self] items in
            guard let strongSelf = self else {return}
            strongSelf.allItems = items
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
