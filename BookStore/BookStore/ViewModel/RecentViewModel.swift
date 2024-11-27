//
//  RecentViewModel.swift
//  BookStore
//
//  Created by Dongik Song on 11/26/24.
//

import Foundation
import CoreData

class RecentViewModel: ObservableObject {
    @Published var recentBooks: [RecentBook] = []
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "RecentBook")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
        fetchRequest()

    }
    
    func fetchRequest() {
        //let request = NSFetchRequest<RecentBook>(entityName: "RecentBook")
        let request: NSFetchRequest = {
            let request = RecentBook.fetchRequest()
            request.fetchLimit = 10
            request.sortDescriptors = [NSSortDescriptor(keyPath: \RecentBook.addedTime, ascending: false)]
            return request
        }()
        
        do {
            recentBooks = try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
    func saveRecent() {
        do {
            try context.save()
            fetchRequest()
        } catch {
            fatalError()
        }
    }
    
    func addRecent(object: Document) {
        let item = RecentBook(context: context)
        item.authors = object.authors.joined(separator: ", ")
        item.contents = object.contents
        item.price = Int64(object.price)
        item.title = object.title
        item.publisher = object.publisher
        item.status = object.status
        item.thumbnail = object.thumbnail
        item.url = object.url
        item.addedTime = Date().timeIntervalSince1970
        context.insert(item)
        saveRecent()
    }
    
    func checkDuplicate(object: Document) -> Bool {
        if recentBooks.contains(where: { $0.title == object.title }) {
            return true
        } else {
            return false
        }
    }
    
    func deleteAll() {
        let request: NSFetchRequest<NSFetchRequestResult> = RecentBook.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            saveRecent()
        } catch {
            fatalError()
        }
    }
}
