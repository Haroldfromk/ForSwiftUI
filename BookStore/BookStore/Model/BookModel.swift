//
//  BookModel.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//

import Foundation

struct BookModel: Codable {
    let meta: Meta
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable, Identifiable {
    let id = UUID()
    let authors: [String]
    let contents: String
    let price: Int
    let publisher: String
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, price, publisher
        case status, thumbnail, title, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
