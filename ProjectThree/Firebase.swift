//
//  Firebase.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/16/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


struct Vendor {
   
   var name: String
   var uID: String?
   var reference: FIRDatabaseReference?
   
   //Snapshot initializer for creating Struct instances when we observe Vendor
   
   init(snapshot: FIRDataSnapshot) {
      //For Jay - Is it better practice to use an if/let statement here?
      let vendorName = snapshot.childSnapshot(forPath: "name")
      name = vendorName.value as! String
      
      uID = snapshot.key
      reference = snapshot.ref
   }
}


struct Customer {
   
   var name: String
   var uID: String?
   var reference: FIRDatabaseReference?
   
   //Snapshot initializer for creating Struct instances when we observe Customer
   
   init(snapshot: FIRDataSnapshot) {
      let customerName = snapshot.childSnapshot(forPath: "name")
      name = customerName.value as! String
      
      uID = snapshot.key
      reference = snapshot.ref
   }
}


struct Item {
   
   var name: String
   var category: String
   var size: String
   var price: Int
   var uID: String?
   var reference: FIRDatabaseReference?
   
   //Snapshot initializer for creating Struct instances when we observe Item
   
   init(snapshot: FIRDataSnapshot) {
      let itemName = snapshot.childSnapshot(forPath: "name")
      name = itemName.value as! String
      let itemCategory = snapshot.childSnapshot(forPath: "category")
      category = itemCategory.value as! String
      let itemSize = snapshot.childSnapshot(forPath: "size")
      size = itemSize.value as! String
      let itemPrice = snapshot.childSnapshot(forPath: "price")
      price = itemPrice.value as! Int
      
      uID = snapshot.key
      reference = snapshot.ref
   }
}



//Change name input to Vendor.name property
func addVendor(name: String) {
   let vendorRef = FIRDatabase.database().reference(withPath: "vendor")
   let vendorChild = vendorRef.childByAutoId()
   let vendorName = vendorChild.child("name")
   vendorName.setValue(name)
}

//Change name input to Customer.name property
func addCustomer(name: String) {
   let customerRef = FIRDatabase.database().reference(withPath: "customer")
   let customerChild = customerRef.childByAutoId()
   let customerName = customerChild.child("name")
   customerName.setValue(name)
}


//Change inputs to Item properties
func addItem(name: String, category: String, size: String, price: Int) {
   let itemRef = FIRDatabase.database().reference(withPath: "item")
   let itemChild = itemRef.childByAutoId()
   let itemName = itemChild.child("name")
   itemName.setValue(name)
   let itemCategory = itemChild.child("category")
   itemCategory.setValue(category)
   let itemSize = itemChild.child("size")
   itemSize.setValue(size)
   let itemPrice = itemChild.child("price")
   itemPrice.setValue(price)
}



func observeChangesInFirebase() {
   let databaseReference = FIRDatabase.database().reference()
   databaseReference.observe(.value, with: { snapshot in databaseChanged(snapshot: snapshot)})
}


// Observes any change throughout the database and calls appropriate child snapshot loop to recreate Struct instances based on snapshot initializers
func databaseChanged(snapshot: FIRDataSnapshot) {
   
   let allVendorsSnapshot = snapshot.childSnapshot(forPath: "vendor")
   for singleVendor in allVendorsSnapshot.children {
      
      if let vendorSnapshot = singleVendor as? FIRDataSnapshot {
         var vendorInstance = Vendor(snapshot: vendorSnapshot)
      }
   }
   
   let allCustomersSnapshot = snapshot.childSnapshot(forPath: "customer")
   for singleCustomer in allCustomersSnapshot.children {
      
      if let customerSnapshot = singleCustomer as? FIRDataSnapshot {
         var customerInstance = Customer(snapshot: customerSnapshot)
      }
   }
   
   let allItemsSnapshot = snapshot.childSnapshot(forPath: "item")
   for singleItem in allItemsSnapshot.children {
      
      if let itemSnapshot = singleItem as? FIRDataSnapshot {
         var itemInstance = Item(snapshot: itemSnapshot)
      }
   }
   
}

//To delete anything
func deleteData(key:String) {
   
   let firebaseRef = FIRDatabase.database().reference(withPath: key)
   firebaseRef.removeValue()
}




//MARK: AUTH FUNCTIONS


func newUserSignup(viewController:UIViewController, emailTextField:String, passwordTextField:String) {
   if emailTextField == "" {
      let alertController = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
      
      let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(defaultAction)
      
      viewController.present(alertController, animated: true, completion: nil)
   } else {
      FIRAuth.auth()?.createUser(withEmail: emailTextField, password: passwordTextField, completion: { (user, error) in
         
         if error == nil {
            print("Signup successful")
            
            let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "Home") //Set home page identifier
            
            viewController.present(vc!, animated: true, completion: nil)

         } else {
            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            viewController.present(alertController, animated: true, completion: nil)
         }
      })
   }
}


func login(email: String, password: String, complete: @escaping (Bool)->()) {
   
   FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
         complete(user != nil)
      }
   }

func logout() {
   
   do {
      try FIRAuth.auth()?.signOut()
   } catch {
      print(error)
   }
}







