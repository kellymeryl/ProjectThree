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


class PreCheckoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   var itemsInCart = [Item]()


    var persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    @IBAction func confirmPurchaseWasTapped(_ sender: Any) {
      
      CoreDataModel.sharedInstance.createCart()
      CoreDataModel.sharedInstance.createItem(category: <#T##String#>, desc: <#T##String#>, name: <#T##String#>, price: <#T##String#>, quantity: <#T##Int16#>, size: <#T##String#>, vendor: <#T##String#>, uID: <#T##String#>, reference: <#T##String#>, imageArray: <#T##[UIImage]#>)
        
        let cartItem = CartItem.insertNewObject(in: managedObjectContext)
        cart.addToItems(cartItem)
        
        
//        UserDefaults.standard.set(cart.objectID.uriRepresentation(), forKey: "user's cart")
  
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
        
        print(cart)
        
    }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PreCheckoutTableViewCell", for: indexPath) as! PreCheckoutTableViewCell
      
 //     cell.itemName.text = itemsInCart[indexPath.row].item
 //     if let price = itemsInCart[indexPath.row]?.price {
 //        cell.itemPrice.text = "\(price)"
 //     }
      
      return cell
      
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return itemsInCart.count
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
