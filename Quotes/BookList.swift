//
//  BookList.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import SwiftData
import SwiftUI

struct BookList: View {
    @Query(sort: \Book.title) private var books: [Book]
    @Environment(\.modelContext) private var context
    @State private var newBook: Book?

    var body: some View {
        NavigationSplitView {
            Group {
                if !books.isEmpty {
                    List {
                        ForEach(books) { book in
                            NavigationLink(book.title) {
                                BookDetail(book: book)
                            }
                        }
                        .onDelete(perform: deleteBooks)
                    }
                } else {
                    ContentUnavailableView("Add Books", systemImage: "book")
                }
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem {
                    Button("Add book", systemImage: "plus", action: addBook)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $newBook) { book in
                NavigationStack {
                    BookDetail(book: book, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Select a book")
                .navigationTitle("Book")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func addBook() {
        let newBook = Book(title: "", author: "", publishDate: .now)
        context.insert(newBook)
        self.newBook = newBook
    }

    private func deleteBooks(indexes: IndexSet) {
        for index in indexes {
            context.delete(books[index])
        }
    }
}

#Preview {
    BookList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty List") {
    BookList()
        .modelContainer(for: Book.self, inMemory: true)
}
