//
//  ListEntryView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/7/26.
//

import SwiftUI
import SwiftData

// Struct for grouping entries by Month
struct MonthGroup: Identifiable {
    var id: String
    var displayName: String
    var entries: [JournalEntry]
}

struct ListEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.creationDate, order: .reverse) private var entries: [JournalEntry]
    
    var body: some View {
        // TODO: Define unique list view that uses branching
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(entries) { entry in
                    HStack(alignment: .top) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                            .frame(width: 20)
                        
                        VStack(alignment: .leading) {
                            Text(entry.creationDate, style: .date)
                            Text(entry.title)
                            Text(entry.content).lineLimit(2)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ListEntryView()
        .modelContainer(for: JournalEntry.self, inMemory: true) {
            result in
            guard let container = try? result.get() else { return }
            
            // Create sample entries
            let entry1 = JournalEntry(
                creationDate: Date(),
                title: "Today's Entry",
                content: "This is a preview of today's journal entry with some content to show how it looks."
            )
            
            let entry2 = JournalEntry(
                creationDate: Date().addingTimeInterval(-86400), // Yesterday
                title: "Yesterday's Thoughts",
                content: "Another entry from yesterday to test the timeline layout."
            )
            
            let entry3 = JournalEntry(
                creationDate: Date().addingTimeInterval(-172800), // 2 days ago
                title: "Weekend Plans",
                content: "Planning for the weekend and thinking about future goals."
            )
            
            container.mainContext.insert(entry1)
            container.mainContext.insert(entry2)
            container.mainContext.insert(entry3)
        }
}
