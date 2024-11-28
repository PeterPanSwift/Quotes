//
//  BookDetail.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import SwiftUI

struct BookDetail: View {
    @Bindable var book: Book
    let isNew: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    init(book: Book, isNew: Bool = false) {
        self.book = book
        self.isNew = isNew
    }

    var sortedQuotes: [Quote] {
        book.quotes.sorted { $0.text < $1.text }
    }

    var body: some View {
        Form {
            TextField("Book title", text: $book.title)
            TextField("Author", text: $book.author)
            DatePicker(
                "Publish date", selection: $book.publishDate,
                displayedComponents: .date)

            if !book.quotes.isEmpty {
                Section("Quotes from this book") {
                    ForEach(sortedQuotes) { quote in
                        Text(quote.text)
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Book" : "Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(book)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookDetail(book: SampleData.shared.book)
    }
}

#Preview("New Book") {
    NavigationStack {
        BookDetail(book: SampleData.shared.book, isNew: true)
    }
}
