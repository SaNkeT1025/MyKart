//
//  AddToCart+CoreDataProperties.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/26/22.
//
//

import Foundation
import CoreData


extension AddToCart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddToCart> {
        return NSFetchRequest<AddToCart>(entityName: "AddToCart")
    }

    @NSManaged public var productDescription: String?
    @NSManaged public var productImage: String?
    @NSManaged public var productName: String?

}

extension AddToCart : Identifiable {

}
