//
//  ItemDetailViewController.swift
//  ProjectThree
//
//  Created by Andrew Moskowitz on 1/16/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var selectedIndex: Int?
    
    var selectedItem = DataModel.sharedInstance.item
   
   var persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
   var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    var cart = CoreDataModel.sharedInstance.cart
    var cartItems = CoreDataModel.sharedInstance.cartItems
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    @IBAction func addToCartButton(_ sender: UIButton) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        let itemUID = selectedItem?.uID
        let predicate = NSPredicate(format: "uID == %@", itemUID!)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            var items = try managedObjectContext.fetch(request) as! [CartItem]
            if items.first?.uID != selectedItem?.uID {
                let currentItem = CoreDataModel.sharedInstance.createItem(firebaseItem: selectedItem!)
                CoreDataModel.sharedInstance.cart.addToItems(currentItem)
                try managedObjectContext.save()
                cartItems.append(currentItem)
                print(itemUID)
            } else {
                items.first?.quantity += 1
                print(itemUID)
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
  
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailCell", for: indexPath) as! ItemDetailCollectionViewCell
      
      
        cell.itemImageURL = self.selectedItem?.imageURLs[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.selectedItem?.imageURLs.count)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let shoppingCartViewController = segue.destination as! ShoppingCartViewController
        shoppingCartViewController.cartItems = cartItems

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        itemNameLabel.text = selectedItem?.name
        itemPriceLabel.text = "\(AllItemsCollectionViewController().convertToCurrency(num: selectedItem!.price))"
        itemDescriptionTextView.text = selectedItem?.description

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
