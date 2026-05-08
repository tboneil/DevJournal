//
//  ListEntryView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/7/26.
//

import SwiftUI
import SwiftData

struct ListEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.creationDate, order: .reverse) private var entries: [JournalEntry]
    
    var body: some View {
        // TODO: Define unique list view that uses branching
    }
    
}

#Preview {
    ListEntryView()
}
