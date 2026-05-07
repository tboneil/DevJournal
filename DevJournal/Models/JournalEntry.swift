//
//  JournalEntry.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/6/26.
//

import Foundation
import SwiftData

@Model
final class JournalEntry {
    var timestamp: Date
    var title: String?
    var body: String?
    
    init(timestamp: Date, title: String? = "New Entry", body: String? = "Type Something Here...") {
        self.timestamp = timestamp
        self.title = title
        self.body = body
    }
}
