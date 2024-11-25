//
//  APIViewModel.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//

import Foundation

@MainActor
class APIViewModel: ObservableObject {
    @Published var books: [Document] = []
    
    func request(searchText: String) async {
        guard let requestedData: BookModel = await APIRequestService().requestAPI(searchText: searchText) else { return }
        books = requestedData.documents
    }
}
