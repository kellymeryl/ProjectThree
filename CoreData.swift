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

   
   func createCart() {
      let cart = Cart(context:context)
   }
   
   
   func createItem(category:String, desc:String, name:String, price:String, quantity:Int16, size:String, vendor:String, uID:String, reference:String, imageArray:[UIImage]) {
      let item = CartItem(context:context)
      item.category = category
      item.desc = desc
      item.name = name
      item.price = price
      item.size = size
      item.quantity = quantity
      item.vendor = vendor
      item.uID = uID
   }
   
   
   
   
   
   
   
   
   
}
