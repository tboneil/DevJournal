//
//  EntryEditorView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/6/26.
//

import SwiftUI
import UniformTypeIdentifiers


struct EntryEditorView: View {
    @State private var title: String = ""
    @State private var entryBody: String = ""
    @FocusState private var isEditorFocused: Bool
    @FocusState private var isTitleFocused: Bool
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 8) {
                Text("New Journal Entry")
                    .font(.headline)
                
                TextField("Entry Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 500)
            }
            .padding(.bottom, 15)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Entry")
                    .font(.headline)
                
                TextEditor(text: $entryBody)
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
                Button(action: saveEntryToDatabase) {
                    Label("Save Entry", systemImage: "square.and.arrow.down")
                }
                .foregroundStyle(Color.blue)
                Button(action: exportEntryToFile) {
                    Label("Export to file", systemImage: "square.and.arrow.up")
                }
                .foregroundStyle(Color.blue)
            }
        }
        .formStyle(.grouped)
    }
    
    private func saveEntryToDatabase() {
        _ = JournalEntry(creationDate: Date(), title: title, content: entryBody)
    }
    
    private func exportEntryToFile() {
        let savePanel = NSSavePanel()
        // .plaintext is a UTT and requires the import
        savePanel.allowedContentTypes = [.plainText]
        savePanel.isExtensionHidden = false
        savePanel.nameFieldStringValue = "\(title).txt"
        savePanel.message = "Save Journal Entry"
        savePanel.showsTagField = true
        savePanel.begin { result in
            if result.rawValue == NSApplication.ModalResponse.abort.rawValue {
                return
            }
            
            guard let url = savePanel.url else { return }
            
            do {
                try entryBody.write(to: url, atomically: true, encoding: .utf8)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    EntryEditorView()
}
