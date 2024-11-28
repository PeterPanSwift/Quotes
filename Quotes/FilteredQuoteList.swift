//
//  FilteredQuoteList.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import SwiftUI

struct FilteredQuoteList: View {
    @State private var searchText = ""

    var body: some View {
        NavigationSplitView {
            QuoteList(textFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select a quote")
                .navigationTitle("Quote")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredQuoteList()
        .modelContainer(SampleData.shared.modelContainer)
}
