//
//  Firebase.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/18/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import UIKit

class FirebaseModel {
   
   static let sharedInstance = FirebaseModel()
   
   
   //MARK: Adding to Firebase Functions
   
   //Change name input to Vendor.name property
   func addVendor(name: String) {
      guard let user = FIRAuth.auth()?.currentUser else {
         return
      }
      let vendorRef = FIRDatabase.database().reference(withPath: "vendor")
      let vendorChild = vendorRef.child(user.uid)
      
      let vendorName = vendorChild.child("name")
      vendorName.setValue(name)
   }
   
   //Change name input to Customer.name property
   func addCustomer(name: String) {
      guard let user = FIRAuth.auth()?.currentUser else {
         return
      }
      let customerRef = FIRDatabase.database().reference(withPath: "customer")
      let customerChild = customerRef.child(user.uid)
      let customerName = customerChild.child("name")
      customerName.setValue(name)
   }
   
   
   //Change inputs to Item properties
   
   
   func addItem(name: String, description:String, category: String, size: String, price: String) {
      let itemRef = FIRDatabase.database().reference(withPath: "item")
      let itemChild = itemRef.childByAutoId()
      let itemName = itemChild.child("name")
      itemName.setValue(name)
      let itemDescription = itemChild.child("description")
      itemDescription.setValue(description)
      let itemCategory = itemChild.child("category")
      itemCategory.setValue(category)
      let itemSize = itemChild.child("size")
      itemSize.setValue(size)
      let itemPrice = itemChild.child("price")
      itemPrice.setValue(price)
      let vendor = itemChild.child("vendor")
      vendor.setValue(FIRAuth.auth()?.currentUser?.uid)
   }
   
   
   //MARK: Observing Firebase Functions
   
   
   func queryItems(searchPath: String, key:String, valueToSearch:String) {
      
      let updatesRef = FIRDatabase.database().reference(withPath: searchPath)
      let query = updatesRef.queryOrdered(byChild: key).queryEqual(toValue: valueToSearch)
      
      query.observeSingleEvent(of: .value, with: { snapshot in
         
         let searchPath = searchPath
         
         for child in snapshot.children {
            if searchPath == "items" {
               
               if let itemSnapshot = child as? FIRDataSnapshot {
                  
                  var itemInstance = Item(snapshot: itemSnapshot)
               }
            } else if searchPath == "vendors" {
               if let vendorSnapshot = child as? FIRDataSnapshot {
                  
                  var vendorInstance = Vendor(snapshot: vendorSnapshot)
                  
               } else {
                  if let customerSnapshot = child as? FIRDataSnapshot {
                     
                     var customerInstance = Vendor(snapshot: customerSnapshot)
                  }
               }
            }
         }
      })
   }
   
   
   
   func observeItems(success: @escaping ([Item]) -> ()) {
      var arrayOfItems = [Item]()
      
      let databaseReference = FIRDatabase.database().reference()
      databaseReference.observeSingleEvent(of: .value, with: { snapshot in
         
         let allItemsSnapshot = snapshot.childSnapshot(forPath: "item")
         for singleItem in allItemsSnapshot.children {
            
            if let itemSnapshot = singleItem as? FIRDataSnapshot {
               var itemInstance = Item(snapshot: itemSnapshot)
               arrayOfItems.append(itemInstance)
            }
         }
         DispatchQueue.main.async {
            success(arrayOfItems)
         }
      })
   }
   
   func observeCustomers(success: @escaping ([Customer]) -> ()) {
      var arrayOfCustomers = [Customer]()
      
      let databaseReference = FIRDatabase.database().reference()
      databaseReference.observeSingleEvent(of: .value, with: { snapshot in
         
         let allCustomersSnapshot = snapshot.childSnapshot(forPath: "customer")
         for singleCustomer in allCustomersSnapshot.children {
            
            if let customerSnapshot = singleCustomer as? FIRDataSnapshot {
               var customerInstance = Customer(snapshot: customerSnapshot)
               arrayOfCustomers.append(customerInstance)
            }
         }
         DispatchQueue.main.async {
            success(arrayOfCustomers)
         }
      })
   }
   
   func observeVendors(success: @escaping ([Vendor]) -> ()) {
      var arrayOfVendors = [Vendor]()
      
      let databaseReference = FIRDatabase.database().reference()
      databaseReference.observeSingleEvent(of: .value, with: { snapshot in
         
         let allVendorsSnapshot = snapshot.childSnapshot(forPath: "vendor")
         for singleVendor in allVendorsSnapshot.children {
            
            if let vendorSnapshot = singleVendor as? FIRDataSnapshot {
               var vendorInstance = Vendor(snapshot: vendorSnapshot)
               arrayOfVendors.append(vendorInstance)
            }
         }
         DispatchQueue.main.async {
            success(arrayOfVendors)
         }
      })
   }
   
   
   //MARK: Deleting From Firebase Functions
   
   //To delete anything
   func deleteData(key:String) {
      
      let firebaseRef = FIRDatabase.database().reference(withPath: key)
      firebaseRef.removeValue()
   }
   
   
   //MARK: Firebase Storage
   
   func uploadImageToFirebase(data: Data, imageName: String) {
      
      let storageRef = FIRStorage.storage().reference()
      let imageRef = storageRef.child(imageName)
      
      let _ = imageRef.put(data, metadata: nil) { (metadata, error) in
         guard let metadata = metadata else {
            return
         }
         let downloadURL = metadata.downloadURL
         print(downloadURL)
      }
   }
   
   
   func downloadImage(name: String, complete: @escaping (UIImage?) -> ()) {
      
      let imageRef = FIRStorage.storage().reference(withPath: name)
      imageRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
         
         if let data = data,
            let image = UIImage(data: data) {
            complete(image)
         }
      }
   }
   
   
   
   //MARK: AUTH FUNCTIONS
   
   
   func newVendorSignup(viewController:UIViewController, name: String, emailTextField:String, passwordTextField:String, complete: @escaping (Bool)->()) {
      if emailTextField == "" {
         let alertController = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         viewController.present(alertController, animated: true, completion: nil)
      } else {
         FIRAuth.auth()?.createUser(withEmail: emailTextField, password: passwordTextField, completion: { (user, error) in
            
            if error == nil {
               self.addVendor(name: name)
               complete(user != nil)
               
            } else {
               let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
               
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(defaultAction)
               
               viewController.present(alertController, animated: true, completion: nil)
            }
         })
      }
   }
   
   
   func newCustomerSignup(viewController:UIViewController, name: String, emailTextField:String, passwordTextField:String, complete: @escaping (Bool)->()) {
      if emailTextField == "" {
         let alertController = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
         
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         
         viewController.present(alertController, animated: true, completion: nil)
      } else {
         FIRAuth.auth()?.createUser(withEmail: emailTextField, password: passwordTextField, completion: { (user, error) in
            
            if error == nil {
               self.addCustomer(name: name)
               complete(user != nil)
               
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
   
}
