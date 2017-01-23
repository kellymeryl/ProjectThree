//
//  CartDataModel.swift
//  ProjectThree
//
//  Created by Kelly McNevin on 1/18/17.
//  Copyright © 2017 Kelly McNevin. All rights reserved.
//

import Foundation
import CoreData



extension CartItem {
    
    static func entityName() -> String {
        return "CartItem"
    }
    
    static func insertNewObject(in managedObjectContext : NSManagedObjectContext) -> CartItem {
        return NSEntityDescription.insertNewObject(forEntityName: CartItem.entityName(), into: managedObjectContext) as! CartItem
    }
    
  func updateWithFirebaseCartItem(firebaseCartItem: Item) {
        self.desc = firebaseCartItem.description
        self.name = firebaseCartItem.name
       // self.price = firebaseCartItem.price
        //self.size = firebaseCartItem.size
    }
    
}
