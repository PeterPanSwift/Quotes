//
//  Book.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var publishDate: Date
    var quotes = [Quote]()

    init(title: String, author: String, publishDate: Date) {
        self.title = title
        self.author = author
        self.publishDate = publishDate
    }

    static let sampleData = [
        Book(title: "小王子", author: "聖修伯里", publishDate: date(1943, 4, 6)),
        Book(title: "彼得潘", author: "巴利", publishDate: date(1904, 12, 27)),
    ]
}
