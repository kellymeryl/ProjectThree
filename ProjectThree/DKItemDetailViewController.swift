//
//  DKItemDetailViewController.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/19/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import UIKit

class DKItemDetailViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate  {
       
    var itemsInCart = [Item]()
    
    
    var persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   
   @IBOutlet weak var itemName: UILabel!
   @IBOutlet weak var itemPrice: UILabel!
   @IBOutlet weak var itemDescription: UITextView!
   
   
   
   @IBAction func addToCartPressed(_ sender: Any) {
      
    let newCart = CoreDataModel.sharedInstance.createCart()
    
    for item in itemsInCart {
        let currentItem = CoreDataModel.sharedInstance.createItem(firebaseItem: item)
        newCart.addToItems(currentItem)
    }
    
    //  let cartItem = CartItem.insertNewObject(in: managedObjectContext)
    //newCart.addToItems(cartItem)
    
    
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
    
    print(newCart)
    
   }
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreCheckoutTableViewCell", for: indexPath) as! PreCheckoutTableViewCell
  
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    


}
