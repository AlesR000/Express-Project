//
//  Note+CoreDataProperties.swift
//  Express
//
//  Created by Alessandro Rippa on 10/12/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var mood: Int16
    @NSManaged public var title: String?
    @NSManaged public var image: Data?
    @NSManaged public var recording: Data?

    var wrappedBody: String {
        body ?? "unknown"
    }
    
    var wrappedTitle: String {
        title ?? "unknown"
    }
    
    var wrappedDate: Date {
        date ?? Date()
    }
 
    
}

extension Note : Identifiable {

}
