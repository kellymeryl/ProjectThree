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
   
   @IBAction func shoppingCartPressed(_ sender: Any) {
      self.performSegue(withIdentifier: "ShopperHomeVCToCartSummary", sender: self)
   }

    
    @IBOutlet weak var allItemsCollection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
   
   var selectedItem: Int?
    
    var allItems = [DataModel.sharedInstance.item] {
        didSet {
            allItemsCollection.reloadData()
        }
    }
    
    var filteredItems = [DataModel.sharedInstance.item] {
        didSet {
            allItemsCollection.reloadData()
        }
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            filteredItems = []
            
            for item in allItems {
                if (item?.name.contains(searchBar.text!))! {
                    filteredItems.append(item)
                }
                print(item)
            }
        }
        else {
            filteredItems = []
        }
        allItemsCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        if searchBar.text != "" {
            return self.filteredItems.count
        }
        else {
            return self.allItems.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! AllItemsCollectionViewCell
        
        if searchBar.text != "" {
            
            let filteredItem = filteredItems[indexPath.row]
            cell.itemNameLabel.text = filteredItem?.name
            if let price = filteredItems[indexPath.item]?.price {
                cell.itemPriceLabel.text = "\(convertToCurrency(num: price))"
            }
            return cell
        }
        else {
         cell.itemImageURL = self.allItems[indexPath.item]?.imageURLs[0]

        
        cell.itemNameLabel.text = allItems[indexPath.item]?.name
        if let price = allItems[indexPath.item]?.price {
            cell.itemPriceLabel.text = "\(convertToCurrency(num: price))"
        }
        return cell
   
        }
    }
    
    func convertToCurrency(num: String) -> String {
        
        let number = NSDecimalNumber(value: Float(num)!)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        let result = numberFormatter.string(from: number)
        
        return result!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShopperHomeVCToCartSummary"{
      } else {
        let itemDetailViewController = segue.destination as! ItemDetailViewController
        itemDetailViewController.selectedIndex = allItemsCollection.indexPathsForSelectedItems?.first?.item
        itemDetailViewController.selectedItem = allItems[(allItemsCollection.indexPathsForSelectedItems?.first?.item)!]
    }
   }
   
   
   @IBAction func unwindFromPurchaseConfirmVCToShopperHomeVC(_ sender: UIStoryboardSegue) {
   
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
    }
}
