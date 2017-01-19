//
//  AllItemsCollectionViewController.swift
//  ProjectThree
//
//  Created by Andrew Moskowitz on 1/16/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit
import Firebase


class AllItemsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var allItemsCollection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allItems = [DataModel.sharedInstance.item] {
        didSet {
            allItemsCollection.reloadData()
        }
    }
    
    var allItemsFiltered = [DataModel.sharedInstance.item] {
        didSet {
            allItemsCollection.reloadData()
        }
    }
    
    var searchActive: Bool = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return allItemsFiltered.count
        } else {
            return allItems.count
        }
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! AllItemsCollectionViewCell
            
            if searchActive {
                cell.itemNameLabel.text = allItemsFiltered[indexPath.item]?.name
                if let price = allItemsFiltered[indexPath.item]?.price {
                    cell.itemPriceLabel.text = "\(convertToCurrency(num: price))"
                    
                }
                return cell
            } else {
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            if searchActive == false {
                allItemsCollection.reloadData()
            } else {
                searchActive = true
                let searchLower = searchBar.text?.lowercased()
                allItemsFiltered = allItemsFiltered.filter({ ($0?.name.range(of: searchLower!) != nil)})
                allItemsCollection.reloadData()
                
            }
        }
        
        allItemsCollection.reloadData()
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
