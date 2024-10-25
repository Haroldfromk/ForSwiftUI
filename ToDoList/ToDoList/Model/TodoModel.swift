//
//  TodoModel.swift
//  ToDoList
//
//  Created by Dongik Song on 10/21/24.
//

import SwiftData

@Model
class TodoModel {
    //#Unique<TodoModel>([\.id])
    
    var id: Int
    var title: String
    var isCompleted: Bool
    
    init(id: Int, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
