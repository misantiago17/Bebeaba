//
//  User+CoreDataProperties.swift
//  
//
//  Created by Michelle Beadle on 09/02/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var nome: String?
    @NSManaged public var semana: String?

}
