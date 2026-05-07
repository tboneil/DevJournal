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
    var creationDate: Date
    var title: String
    var content: String
    
    init(creationDate: Date, title: String, content: String) {
        self.creationDate = creationDate
        self.title = title
        self.content = content
    }
}
