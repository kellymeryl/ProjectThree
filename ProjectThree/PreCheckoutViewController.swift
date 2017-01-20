//
//  PreCheckoutViewController.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/18/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreData

var item1 = Item(name: "name", category: "m", size: "s", price: "10", image: [#imageLiteral(resourceName: "Lumber Placeholder.png")] , description: "description")
var item2 = Item(name: "name2", category: "m", size: "M", price: "12", image: [#imageLiteral(resourceName: "Shopping Cart.png")], description: "desc")

class PreCheckoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var itemsInCart = [item1, item2]
    
    //Core Data
    var persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBAction func confirmPurchaseWasTapped(_ sender: Any) {
        
        let newCart = CoreDataModel.sharedInstance.createCart()
        
        for item in itemsInCart {
            let currentItem = CoreDataModel.sharedInstance.createItem(firebaseItem: item)
            newCart.addToItems(currentItem)
            
        }
        
        
        do {
            try  managedObjectContext.save()
        } catch {
            ()
        }
        
        do {
            if let url = UserDefaults.standard.url(forKey: "user's cart") {
                if let objectID = managedObjectContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) {
                    let persistedCart = managedObjectContext.object(with: objectID)
                    print(persistedCart)
                }
            }
        } catch {
            ()
        }
        
        print(newCart)
        
    }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PreCheckoutTableViewCell", for: indexPath) as! PreCheckoutTableViewCell
      
      cell.itemName.text = CoreDataModel.sharedInstance.cartItems[indexPath.row].name
      cell.itemPrice.text = CoreDataModel.sharedInstance.cartItems[indexPath.row].price
      
      return cell
      
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return CoreDataModel.sharedInstance.cartItems.count
   }
   
   
   func getCurrentUser() {
      
      if FIRAuth.auth()?.currentUser != nil {
         let vendorEmail = FIRAuth.auth()?.currentUser?.email
         print(vendorEmail)
      } else {
         return
      }   }
   
   
   
   
   
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
