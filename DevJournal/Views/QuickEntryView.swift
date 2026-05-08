//
//  QuickEntryView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/7/26.
//

import SwiftUI
import SwiftData

struct QuickEntryView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Query to retrieve journal entries from database
    @Query(sort: \JournalEntry.creationDate, order: .reverse) private var entries: [JournalEntry]
    
    @State private var selectedEntry: JournalEntry?
    
    var body: some View {
        NavigationSplitView {
            // Sidebar: List of entries
            List(entries, selection: $selectedEntry) { entry in
                NavigationLink(value: entry) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.title.isEmpty ? "Untitled Entry" : entry.title)
                            .font(.headline)
                        
                        Text(entry.creationDate, format: .dateTime.month().day().year().hour().minute())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Journal Entries")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addEntry) {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
            }
        } detail: {
            // Detail view: Show selected entry or placeholder
            if let selectedEntry {
                EntryDetailView(entry: selectedEntry)
            } else {
                ContentUnavailableView(
                    "No Entry Selected",
                    systemImage: "book.closed",
                    description: Text("Select a journal entry from the sidebar to view its contents")
                )
            }
        }
    }
    
    private func addEntry() {
        let newEntry = JournalEntry(
            creationDate: Date(),
            title: "New Entry",
            content: ""
        )
        modelContext.insert(newEntry)
        selectedEntry = newEntry
    }
}

// Detail view for displaying an entry
struct EntryDetailView: View {
    @Bindable var entry: JournalEntry
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                TextField("Entry Title", text: $entry.title, axis: .vertical)
                    .font(.title)
                    .fontWeight(.bold)
                    .textFieldStyle(.plain)
                
                // Date
                Text(entry.creationDate, format: .dateTime.month().day().year().hour().minute())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                // Content
                TextEditor(text: $entry.content)
                    .font(.body)
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 300)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    QuickEntryView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
