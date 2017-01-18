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
import FirebaseStorage
import UIKit


struct Vendor {
   
   var name: String
   var uID: String?
   var reference: FIRDatabaseReference?
   
   init(name:String) {
      self.name = name
   }
   
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
   var paymentInformation: PaymentInformation?
   var shippingInformation: ShippingInformation?
   var uID: String?
   var reference: FIRDatabaseReference?
   
   
   init(name: String, uID: String)
   {
      self.name = name
      self.uID = uID
   }
   
   
   //Snapshot initializer for creating Struct instances when we observe Customer
   init(snapshot: FIRDataSnapshot) {
      let customerName = snapshot.childSnapshot(forPath: "name")
      name = customerName.value as! String
      
      uID = snapshot.key
      reference = snapshot.ref
   }
}


struct PaymentInformation {
   var creditCardNumber: String
   var creditCardExpiration: String
   var creditCardSecurityCode: String
   
   init(creditCardNumber: String, creditCardExpiration: String, creditCardSecurityCode: String) {
      self.creditCardNumber = creditCardNumber
      self.creditCardExpiration = creditCardExpiration
      self.creditCardSecurityCode = creditCardSecurityCode
   }
}

struct ShippingInformation {
   var firstName: String
   var lastName: String
   var streetName: String
   var streetNumber: String
   var apartment:String?
   var zipCode: String
   var city: String
   var state: String
   var country: String
   
   init(firstName: String, lastName: String, streetName: String, streetNumber: String, zipCode: String, city: String, state: String, country: String)
   {
      self.firstName = firstName
      self.lastName = lastName
      self.streetName = streetName
      self.streetNumber = streetNumber
      self.zipCode = zipCode
      self.city = city
      self.state = state
      self.country = country
   }
}


struct Item {
   
   var name: String
   var category: String
   var size: String
   var price: Float
   var image: [UIImage]?
   var description: String
   var vendor: String?
   var uID: String?
   var reference: FIRDatabaseReference?
   
   init(name:String, category:String, size:String, price:Float, image:[UIImage]?, description:String) {
      self.name = name
      self.category = category
      self.size = size
      self.price = price
      self.image = image
      self.description = description
   }
   
   //Snapshot initializer for creating Struct instances when we observe Item
   init(snapshot: FIRDataSnapshot) {
      let itemName = snapshot.childSnapshot(forPath: "name")
      name = itemName.value as! String
      let itemCategory = snapshot.childSnapshot(forPath: "category")
      category = itemCategory.value as! String
      let itemSize = snapshot.childSnapshot(forPath: "size")
      size = itemSize.value as! String
      let itemPrice = snapshot.childSnapshot(forPath: "price")
      price = itemPrice.value as! Float
      let itemDescription = snapshot.childSnapshot(forPath: "description")
      description = itemDescription.value as! String

      
      uID = snapshot.key
      reference = snapshot.ref
   }
}


//MARK: Adding to Firebase Functions


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
func addItem(name: String, description:String, category: String, size: String, price: Int, vendorUID: String) {
   let itemRef = FIRDatabase.database().reference(withPath: "item")
   let itemChild = itemRef.childByAutoId()
   let itemName = itemChild.child("name")
   itemName.setValue(name)
   let itemDescription = itemRef.childByAutoId()
   itemDescription.setValue(description)
   let itemCategory = itemChild.child("category")
   itemCategory.setValue(category)
   let itemSize = itemChild.child("size")
   itemSize.setValue(size)
   let itemPrice = itemChild.child("price")
   itemPrice.setValue(price)
   let vendor = itemRef.childByAutoId()
   vendor.setValue(vendorUID)
}


//MARK: Observing Firebase Functions

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
   let imageRef = storageRef.child(NSUUID().uuidString)
   
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
            
            let homeStoryboard: UIStoryboard = UIStoryboard(name: "CustomerUI", bundle: nil)
            
            let vc = homeStoryboard.instantiateInitialViewController()
            
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








