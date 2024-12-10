//
//  Persistence.swift
//  SwiftCal
//
//  Created by Dongik Song on 12/10/24.
//

import Foundation
import SwiftData

struct Persistence {
    
    static var container: ModelContainer {
        let container: ModelContainer = {
            let sharedStoreURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.HaroldSong.SwiftCal")!.appendingPathComponent("SwiftCal.sqlite")
            let config = ModelConfiguration(url: sharedStoreURL)
            return try! ModelContainer(for: Day.self, configurations: config)
        }()
        
        return container
    }
    
    static var currentDay: Day? {
        let context = ModelContext(Persistence.container)
        let today = Date()
        let predicate = #Predicate<Day> { $0.date == today.startOfDay }
        let descriptor = FetchDescriptor(predicate: predicate)
        
        return try? context.fetch(descriptor).first
    }
}
