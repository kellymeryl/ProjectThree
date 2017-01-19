//
//  Cart+CoreDataProperties.swift
//  
//
//  Created by Kelly McNevin on 1/18/17.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart");
    }

    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Cart {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CartItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CartItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

