//
//  UserEntity+CoreDataProperties.swift
//  Milestone5
//
//  Created by admin on 24/02/2023.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var profilePhoto: Data?
    @NSManaged public var role: String?
    @NSManaged public var about: String?
    @NSManaged public var eventRelation: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedRole: String {
        role ?? "Unknown role"
    }
    public var wrappedAbout: String {
        about ?? "Unknown about"
    }
    private var wrappedID: UUID {
        id ?? UUID()
    }
    
    public var eventArray: [EventEntity] {
        let set = eventRelation as? Set<EventEntity> ?? []
            
        return set.sorted{ $0.wrappedType < $1.wrappedType }
        
    }


}

// MARK: Generated accessors for eventRelation
extension UserEntity {

    @objc(addEventRelationObject:)
    @NSManaged public func addToEventRelation(_ value: EventEntity)

    @objc(removeEventRelationObject:)
    @NSManaged public func removeFromEventRelation(_ value: EventEntity)

    @objc(addEventRelation:)
    @NSManaged public func addToEventRelation(_ values: NSSet)

    @objc(removeEventRelation:)
    @NSManaged public func removeFromEventRelation(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
