//
//  Book.swift
//  BookFinderWithCodable
//
//  Created by yuri on 2022/10/24.
//

import Foundation

//meta
struct Meta: Codable {
    let total_count: Int
    let pageable_count: Int
    let is_end: Bool
}

//documents
struct Book: Codable {
    let title: String
    let contents: String
    let url: String
    let isbn: String
    let datetime: String // Date
    let authors: [String]
    let publisher: String
    let translators: [String]
    let price: Int
    let sale_price: Int
    let thumbnail: String
    let status: String
}

struct ResultData: Codable {
    let meta: Meta
    let documents: [Book]
}


