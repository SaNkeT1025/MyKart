//
//  UserData+CoreDataProperties.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/26/22.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var name: String?
    @NSManaged public var emailId: String?
    @NSManaged public var mobile: String?
    @NSManaged public var password: String?

}

extension UserData : Identifiable {

}
