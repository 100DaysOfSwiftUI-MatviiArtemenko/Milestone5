//
//  TestingAppApp.swift
//  TestingApp
//
//  Created by admin on 25/02/2023.
//

import SwiftUI

@main
struct Milestone5: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
