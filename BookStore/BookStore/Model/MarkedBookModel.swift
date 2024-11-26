//
//  MarkedBookModel.swift
//  BookStore
//
//  Created by Dongik Song on 11/26/24.
//

import Foundation
import SwiftData

@Model
class MarkedBookModel: Identifiable {
    var id = UUID()
    var authors: String
    var contents: String
    var price: Int
    var publisher: String
    var status: String
    var thumbnail: String
    var title: String
    var url: String
    
    init(id: UUID = UUID(), authors: String, contents: String, price: Int, publisher: String, status: String, thumbnail: String, title: String, url: String) {
        self.id = id
        self.authors = authors
        self.contents = contents
        self.price = price
        self.publisher = publisher
        self.status = status
        self.thumbnail = thumbnail
        self.title = title
        self.url = url
    }
}
