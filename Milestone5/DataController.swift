//
//  DataController.swift
//  Milestone5
//
//  Created by admin on 23/02/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "DataModel")
    @Published var savedEvents: [EventEntity] = []
    
    init() {
        container.loadPersistentStores { description , error in
            if let error = error {
                print("error occured: \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        fetchCoreData()
        
    }
    func fetchCoreData() {
        let request = NSFetchRequest<EventEntity>(entityName: "EventEntity")
        
        do {
            savedEvents = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchCoreData()
        } catch let error {
            print("error occured \(error.localizedDescription)")
        }
    }
}
