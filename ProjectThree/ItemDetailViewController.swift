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
   
   
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    @IBAction func addToCartButton(_ sender: UIButton) {
      
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
      let itemuID = selectedItem?.uID
      let predicate = NSPredicate(format: "name == %@", "Shirt")
      request.predicate = predicate
      request.fetchLimit = 1
      
      do {
         var items = try managedObjectContext.fetch(request) as! [CartItem]
         print(items.first?.quantity)
         if items.first?.name != selectedItem?.name {
            print("Item is not already in the cart")
            print(items.first?.name)
         } else {
            items.first?.quantity += 1
            print(items.first?.quantity)

            print(items.count)
         }
      }
      catch let error as NSError {
         print("Could not fetch \(error), \(error.userInfo)")
      }
    
    }
   
   /*
   let currentItem = CoreDataModel.sharedInstance.createItem(firebaseItem: selectedItem!)
   CoreDataModel.sharedInstance.cart.addToItems(currentItem)
   
   do {
   try managedObjectContext.save()
   } catch {
   print(error.localizedDescription)
   }
   
   */
   
  
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailCell", for: indexPath) as! ItemDetailCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

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
