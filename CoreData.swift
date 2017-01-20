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

   
    func createCart() -> Cart {
        let cart = Cart(context:context)
        return cart
    }
   
    
    func createItem(firebaseItem: Item) -> CartItem {
        
      let item = CartItem(context:context)
      item.category = firebaseItem.category
      item.desc = firebaseItem.description
      item.name = firebaseItem.name
      item.price = firebaseItem.price
      item.size = firebaseItem.size
      item.vendor = firebaseItem.vendor
      item.uID = firebaseItem.uID
        return item
   
    }
   
   
   
   
   
   
   
   
   
}
