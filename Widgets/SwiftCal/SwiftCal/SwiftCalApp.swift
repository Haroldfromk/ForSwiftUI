//
//  SwiftCalApp.swift
//  SwiftCal
//
//  Created by Dongik Song on 12/6/24.
//

import SwiftUI

@main
struct SwiftCalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CalendarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
