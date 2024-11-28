//
//  SampleData.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()

    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    var quote: Quote {
        Quote.sampleData.first!
    }

    var book: Book {
        Book.sampleData.first!
    }

    private init() {
        let schema = Schema([Quote.self, Book.self])
        let modelConfiguration = ModelConfiguration(
            schema: schema, isStoredInMemoryOnly: true)

        do {
            modelContainer = try ModelContainer(
                for: schema, configurations: [modelConfiguration])
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func insertSampleData() {
        for quote in Quote.sampleData {
            context.insert(quote)
        }
        for book in Book.sampleData {
            context.insert(book)
        }

        Quote.sampleData[0].fromBook = Book.sampleData[0]
        Quote.sampleData[1].fromBook = Book.sampleData[1]
    }
}
