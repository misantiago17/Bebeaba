//
//  Exame+CoreDataProperties.swift
//  
//
//  Created by Michelle Beadle on 09/02/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Exame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exame> {
        return NSFetchRequest<Exame>(entityName: "Exame");
    }

    @NSManaged public var data: NSDate?
    @NSManaged public var descricao: String?
    @NSManaged public var hora: NSDate?
    @NSManaged public var local: String?
    @NSManaged public var nome: String?
    @NSManaged public var tipo: String?

}
