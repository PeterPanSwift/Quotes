//
//  ContentView.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Quotes", systemImage: "quote.bubble") {
                FilteredQuoteList()
            }
            Tab("Books", systemImage: "book") {
                BookList()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
