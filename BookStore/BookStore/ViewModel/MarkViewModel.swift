//
//  MarkViewModel.swift
//  BookStore
//
//  Created by Dongik Song on 11/26/24.
//

import Foundation
import SwiftData

@MainActor
class MarkViewModel: ObservableObject {
    @Published var book = [MarkedBookModel]()
    
    private let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    init() {
//        let fileManager = FileManager.default
//        if let containerURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
//            let storeURL = containerURL.appendingPathComponent("Model.sqlite")
//            print(storeURL)
//        }
//
        do {
            self.modelContainer = try ModelContainer(for: MarkedBookModel.self)
            self.modelContext = modelContainer.mainContext
            self.modelContext.undoManager = UndoManager()
            fetchRequest()
        } catch {
            fatalError()
        }
        
    }
    
    // Read
    func fetchRequest() {
        do {
            book = try modelContext.fetch(FetchDescriptor<MarkedBookModel>())
        } catch {
            fatalError()
        }
    }
        
    func saveContext() {
        do {
            try modelContext.save()
            fetchRequest()
        } catch {
            fatalError()
        }
    }
    
    // Create
    func addMark(object: Document) {
        let item = MarkedBookModel(authors: object.authors.joined(separator: ", "),
                                   contents: object.contents,
                                   price: object.price,
                                   publisher: object.publisher,
                                   status: object.status,
                                   thumbnail: object.thumbnail,
                                   title: object.title,
                                   url: object.url)
        modelContext.insert(item)
        saveContext()
    }
    
    // Delete
    func deleteMark(object: MarkedBookModel) {
        modelContext.delete(object)
        saveContext()
    }
    
    // DeleteAll
    func deleteAllMark() {
        do {
            try modelContext.delete(model: MarkedBookModel.self)
            saveContext()
        } catch {
            fatalError()
        }
    }
    
    // Checking Duplicate
    func checkDuplicate(object: Document) -> Bool {
        if book.contains(where: { $0.title == object.title }) {
            return true
        } else {
            return false
        }
    }
    
    // Undo
    func undoAction() {
        modelContext.undoManager!.undo()
        saveContext()
    }
    
    // Redo
    func redoAction() {
        modelContext.undoManager!.redo()
        saveContext()
    }

}
