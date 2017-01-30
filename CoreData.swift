//
//  CoreData.swift
//  ProjectThree
//
//  Created by Dan Hefter on 1/19/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataModel {
   
   static let sharedInstance = CoreDataModel()
   private init(){}
   
   lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
   var cartItems: [CartItem] {
      
      var items = [CartItem]()
      let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
      
      do {
         items = try context.fetch(request)
      } catch {
         print(error)
      }
      return items
   }
   
   
   var cart: Cart {
      let cart = CoreDataModel.sharedInstance.createCart()
      return cart
   }
   
   
   func createCart() -> Cart {
      let cart = Cart(context:context)
      return cart
   }
   
   
   func createItem(firebaseItem: Item) -> CartItem {
      
      let item = CartItem(context:context)
      item.desc = firebaseItem.description
      item.name = firebaseItem.name
      item.price = firebaseItem.price
      //   item.size = firebaseItem.size
      item.color = firebaseItem.color
      item.vendor = firebaseItem.vendor
      item.uID = firebaseItem.uID
      item.quantity = 1
      return item
      
   }
   
   func addToItem(firebaseItem: Item) -> CartItem {
      
      let item = CartItem(context:context)
      item.desc = firebaseItem.description
      item.name = firebaseItem.name
      item.price = firebaseItem.price
      item.color = firebaseItem.color
      item.vendor = firebaseItem.vendor
      item.uID = firebaseItem.uID
      item.quantity += 1
      return item
      
   }
   
   
   func clearShoppingCart(cart: [CartItem]) {
      // Look at using a deleteBatchRequest to do this more efficiently
      
      let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
      fetchRequest.returnsObjectsAsFaults = false
      
      do
      {
         let results = try context.fetch(fetchRequest)
         for managedObject in results
         {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            context.delete(managedObjectData)
         }
      } catch let error as NSError {
         print("Delete all data in \(cart) error : \(error) \(error.userInfo)")
      }
   }
   
   
   
}

