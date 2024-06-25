//
//  Recent+CoreDataProperties.swift
//  CleanArchitecture
//
//  Created by Tarun Khurana on 5/28/24.
//
//

import Foundation
import CoreData


extension Recent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recent> {
        return NSFetchRequest<Recent>(entityName: "Recent")
    }

    @NSManaged public var value: String?
    @NSManaged public var time: Date?

}

extension Recent : Identifiable {

}
