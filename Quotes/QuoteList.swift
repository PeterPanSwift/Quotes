//
//  QuoteList.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import SwiftData
import SwiftUI

struct QuoteList: View {
    @Query private var quotes: [Quote]
    @Environment(\.modelContext) private var context
    @State private var newQuote: Quote?

    init(textFilter: String = "") {
        let predicate = #Predicate<Quote> { quote in
            textFilter.isEmpty
                || quote.text.localizedStandardContains(textFilter)
        }
        _quotes = Query(filter: predicate, sort: \Quote.text)
    }

    var body: some View {
        Group {
            if !quotes.isEmpty {
                List {
                    ForEach(quotes) { quote in
                        NavigationLink(quote.text) {
                            QuoteDetail(quote: quote)
                        }
                    }
                    .onDelete { indexSet in
                        deleteQuotes(indexes: indexSet)
                    }
                }
            } else {
                ContentUnavailableView(
                    "Add Quotes", systemImage: "quote.bubble")
            }
        }
        .navigationTitle("Quotes")
        .toolbar {
            ToolbarItem {
                Button("Add quote", systemImage: "plus", action: addQuote)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newQuote) { quote in
            NavigationStack {
                QuoteDetail(quote: quote, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }

    private func addQuote() {
        let newQuote = Quote(text: "")
        context.insert(newQuote)
        self.newQuote = newQuote
    }

    private func deleteQuotes(indexes: IndexSet) {
        for index in indexes {
            context.delete(quotes[index])
        }
    }
}

#Preview {
    NavigationStack {
        QuoteList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        QuoteList(textFilter: "to be")
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack {
        QuoteList()
            .modelContainer(for: Quote.self, inMemory: true)
    }
}
