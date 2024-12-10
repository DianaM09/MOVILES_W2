//
//  EazyShoesApp.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

@main
struct EazyShoesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
