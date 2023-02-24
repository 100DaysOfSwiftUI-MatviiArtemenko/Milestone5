//
//  Milestone5App.swift
//  Milestone5
//
//  Created by admin on 20.09.2022.
//

import SwiftUI

@main
struct Milestone5App: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
