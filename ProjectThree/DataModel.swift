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

class DataModel {
   
   static let sharedInstance = DataModel()

   var vendor: Vendor?
   var item:Item?
   var customer:Customer?
}

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







