//
//  Conversion+CoreDataProperties.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 07/02/25.
//
//

import Foundation
import CoreData


extension Conversion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Conversion> {
        return NSFetchRequest<Conversion>(entityName: "Conversion")
    }

    @NSManaged public var key: String?
    @NSManaged public var value: Double

}

extension Conversion : Identifiable {

}
