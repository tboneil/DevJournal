//
//  MainView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/7/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Query(sort: \JournalEntry.creationDate, order: .reverse) private var entries: [JournalEntry]
    @State private var entry: JournalEntry?
    
    var body: some View {
        NavigationSplitView {
            List(entries, selection: $entry) { entry in
                NavigationLink(value: entry) {
                    VStack {
                        Text(entry.title)
                            .font(.headline)
                        
                        Text(entry.creationDate, format: .dateTime.month().day().year())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Entries")
        } detail: {
            MainDetailView()
        }
    }
        
}


#Preview {
    MainView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
