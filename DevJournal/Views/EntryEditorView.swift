//
//  EntryEditorView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/6/26.
//

import SwiftUI
import UniformTypeIdentifiers
import SwiftData


struct EntryEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var existingEntry: JournalEntry?
    
    @State private var title: String = ""
    @State private var content: String = ""
    @FocusState private var isEditorFocused: Bool
    @FocusState private var isTitleFocused: Bool
    
    var isNewEntry: Bool {
        existingEntry == nil
    }
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 8) {
                Text(isNewEntry ? "Journal Entry" : "Edit Journal Entry")
                    .font(.headline)
                
                TextField("Entry Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 500)
            }
            .padding(.bottom, 15)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Entry")
                    .font(.headline)
                
                TextEditor(text: $content)
                    .frame(maxWidth: 500, minHeight: 200)
                    .focused($isEditorFocused)
                    .padding(10)
                    .background(Color(.textBackgroundColor))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isEditorFocused ? Color.accentColor : Color.gray.opacity(0.3), lineWidth: isEditorFocused ? 2 : 1)
                    )
                    .foregroundStyle(Color.primary)
                    .lineSpacing(10)
                    .font(.system(size: 15))
            }
            
            HStack {
                
                Button(action: saveEntry) {
                    Label(isNewEntry ? "Create Entry" : "Save Changes", systemImage: "square.and.arrow.down")
                }
                .buttonStyle(.borderedProminent)
                
                
                Button(action: exportToFile) {
                    Label("Export to file", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(.bordered)
            }
        }
        .formStyle(.grouped)
        .onAppear {
            loadEntryData()
        }
        .onChange(of: existingEntry) { oldValue, newValue in
            loadEntryData()
        }
    }
    
    private func loadEntryData() {
        if let entry = existingEntry {
            // Editing existing entry - load its data
            title = entry.title
            content = entry.content
        } else {
            // New entry - clear the form
            title = ""
            content = ""
        }
    }
    
    private func saveEntry() {
        if let entry = existingEntry {
            // Editing existing entry - update it
            entry.title = title
            entry.content = content
            // No insert needed - already in database!
        } else {
            // Creating new entry - insert it
            let newEntry = JournalEntry(
                creationDate: Date(),
                title: title,
                content: content
            )
            modelContext.insert(newEntry)
        }
        
        // Clear form
        title = ""
        content = ""
        
        // Optional: dismiss the view
        dismiss()
    }
    
    private func exportToFile() {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.plainText]
        savePanel.isExtensionHidden = false
        savePanel.nameFieldStringValue = "\(title).txt"
        savePanel.message = "Export Journal Entry"
        savePanel.showsTagField = true
        
        savePanel.begin { result in
            guard result == .OK, let url = savePanel.url else { return }
            
            do {
                try content.write(to: url, atomically: true, encoding: .utf8)
                print("✅ Exported successfully!")
            } catch {
                print("❌ Export failed: \(error)")
            }
        }
    }
}

#Preview("New Entry") {
    EntryEditorView(existingEntry: nil)
        .modelContainer(for: JournalEntry.self, inMemory: true)
}

#Preview("Edit Entry") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: JournalEntry.self, configurations: config)
    
    let sampleEntry = JournalEntry(
        creationDate: Date(),
        title: "Sample Entry",
        content: "This is sample content for the preview."
    )
    container.mainContext.insert(sampleEntry)
    
    return EntryEditorView(existingEntry: sampleEntry)
        .modelContainer(container)
}
