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
    @State private var selectedTab = 0
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                Tab("Calendar", systemImage: "calendar", value: 0) {
                    CalendarView()
                }
                Tab("Streak", systemImage: "swift", value: 1) {
                    StreakView()
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .onOpenURL { url in
                selectedTab = url.absoluteString == "calendar" ? 0 : 1
            }
        }
    }
}
