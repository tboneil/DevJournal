//
//  ExportEntryToFileView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/9/26.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct ExportEntryToFileView: View {
    @Query private var journalEntries: [JournalEntry]
    let entriesToExport: [JournalEntry]?
    var entries: [JournalEntry] {
        entriesToExport ?? journalEntries
    }
    
    var body: some View {
        
        // View Defined
        VStack {
            Text("Export \(entries.count) entries")
            
            Button("Export to Plain Text") {
                exportToDisk()  // ← Button calls this
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // Define Functions for exporting files
    func exportToDisk() {
        let plainTextContent = convertToTxt()
        
        showSavePanel(content: plainTextContent)
    }
    
    func convertToTxt() -> String {
        var text = ""
        for entry in entries {
            text += "Title: \(entry.title)\n"
            text += "Date: \(entry.creationDate.formatted())\n"
            text += "Content:\n\(entry.content)\n"
            text += "\n" + String(repeating: "-", count: 50) + "\n\n"
        }
        return text
    }
    
    func showSavePanel(content: String) {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.plainText]
        savePanel.nameFieldStringValue = "journal_export.txt"
        savePanel.message = "Export Journal Entries"
        
        savePanel.begin { result in
            guard result == .OK, let url = savePanel.url else { return }
            
            // Step 3: Write the converted content
            do {
                try content.write(to: url, atomically: true, encoding: .utf8)
                print("✅ Exported successfully!")
            } catch {
                print("❌ Export failed: \(error)")
            }
        }
    }
}

#Preview {
    ExportEntryToFileView(entriesToExport: nil)
        .modelContainer(for: JournalEntry.self, inMemory: true) { result in
            #if DEBUG
            guard let container = try? result.get() else { return }
            
            let sample1 = JournalEntry(
                creationDate: Date(),
                title: "Preview Entry 1",
                content: "Sample content for preview testing."
            )
            
            let sample2 = JournalEntry(
                creationDate: Date().addingTimeInterval(-86400),
                title: "Preview Entry 2",
                content: "Another sample entry."
            )
            
            container.mainContext.insert(sample1)
            container.mainContext.insert(sample2)
            #endif
        }
}
