//
//  QuoteDetail.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import SwiftData
import SwiftUI

struct QuoteDetail: View {
    @Bindable var quote: Quote
    let isNew: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]

    init(quote: Quote, isNew: Bool = false) {
        self.quote = quote
        self.isNew = isNew
    }

    var body: some View {
        Form {
            TextField("Quote text", text: $quote.text)
            Picker("From Book", selection: $quote.fromBook) {
                Text("None")
                    .tag(nil as Book?)

                ForEach(books) { book in
                    Text(book.title)
                        .tag(book as Book?)
                }
            }
        }
        .navigationTitle(isNew ? "New Quote" : "Quote")
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
                        context.delete(quote)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuoteDetail(quote: SampleData.shared.quote)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Quote") {
    NavigationStack {
        QuoteDetail(quote: SampleData.shared.quote, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
