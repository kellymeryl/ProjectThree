//
//  CartItem+CoreDataProperties.swift
//  
//
//  Created by Kelly McNevin on 1/18/17.
//
//

import Foundation
import CoreData


extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem");
    }

    @NSManaged public var category: String?
    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var quantity: Int16
    @NSManaged public var size: String?
    @NSManaged public var uID: String?
    @NSManaged public var vendor: String?
    @NSManaged public var cart: Cart?

}
