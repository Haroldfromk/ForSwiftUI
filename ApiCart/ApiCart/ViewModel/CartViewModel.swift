//
//  CartViewModel.swift
//  ApiCart
//
//  Created by Dongik Song on 11/14/24.
//

import Foundation
import CoreData

class CartViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var cart: [Cart] = []
    
    init() {
        container = NSPersistentContainer(name: "Cart")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        fetchRequest()
    }
    
    func fetchRequest() {
        let request = NSFetchRequest<Cart>(entityName: "Cart")
        
        do {
            cart = try container.viewContext.fetch(request)
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    func addCart(model: WishModel) {
        let item = Cart(context: container.viewContext)
        item.id = Int64(model.id)
        item.title = model.title
        item.price = model.price
        
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchRequest()
        } catch {
            print("Save failed: \(error)")
        }
    }
    
    func deleteData(object: Cart) {
        container.viewContext.delete(object)
        saveData()
    }
    
    func deleteAllData() {
        let request: NSFetchRequest<NSFetchRequestResult> = Cart.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try container.viewContext.execute(deleteRequest)
            saveData()
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    func checkDuplicate(title: String) -> Bool {
        if cart.contains(where: { $0.title == title }) {
            return true
        } else {
            return false
        }
    }
}

