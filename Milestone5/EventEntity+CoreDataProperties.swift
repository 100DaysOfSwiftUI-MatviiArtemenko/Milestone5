//
//  EventEntity+CoreDataProperties.swift
//  Milestone5
//
//  Created by admin on 24/02/2023.
//
//

import Foundation
import CoreData


extension EventEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventImage: Data?
    @NSManaged public var peopleRegistered: Int16
    @NSManaged public var address: String?
    @NSManaged public var type: String?
    @NSManaged public var userRelation: UserEntity?
    
    public var wrappedTitle: String {
        title ?? "Unknown title"
    }
    
    public var wrappedDescription: String {
        eventDescription ?? "blank description"
    }

    public var wrappedPeopleRegistered: Int {
        Int(peopleRegistered) ?? 0
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var wrappedType: String {
        type ?? "Unknown type"
    }




}

extension EventEntity : Identifiable {

}
