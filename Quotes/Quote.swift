//
//  Quote.swift
//  Quotes
//
//  Created by SHIH-YING PAN on 2024/11/14.
//

import Foundation
import SwiftData

@Model
class Quote {
    var text: String
    var fromBook: Book?

    init(text: String, fromBook: Book? = nil) {
        self.text = text
        self.fromBook = fromBook
    }

    static let sampleData = [
        Quote(
            text: "如果你馴養了我，我們就彼此需要了。"),
        Quote(
            text: "無論在任何年紀，你都要擁有一顆赤子之心"),
    ]
}

func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    let components = DateComponents(year: year, month: month, day: day)
    return Calendar.current.date(from: components) ?? Date()
}
