//
//  SDCartViewModel.swift
//  ApiCart
//
//  Created by Dongik Song on 11/16/24.
//

import SwiftUI
import SwiftData

@MainActor
class SDCartViewModel: ObservableObject {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @Published var cart: [SDCartModel] = []
    
    init() {
        self.modelContainer = try! ModelContainer(for: SDCartModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchRequest() {
        do {
            cart = try modelContext.fetch(FetchDescriptor<SDCartModel>())
        } catch {
            fatalError()
        }
    }
    
    func saveCart() {
        do {
            try modelContext.save()
            fetchRequest()
        } catch {
            fatalError()
        }
    }
    
    func addCart(model: WishModel) {
        let item = SDCartModel(id: model.id, title: model.title, price: model.price)
        modelContext.insert(item)
        saveCart()
    }
    
    func deleteCart(object: SDCartModel) {
        modelContext.delete(object)
        saveCart()
    }
    
    func deleteAllCart() {
        do {
            try modelContext.delete(model: SDCartModel.self)
            saveCart()
        } catch {
            fatalError()
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
