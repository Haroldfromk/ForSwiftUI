//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Dongik Song on 10/16/24.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TodoModel.self)
        }
    }
}
