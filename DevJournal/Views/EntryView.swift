//
//  EntryView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/11/26.
//

import SwiftUI
import SwiftData

struct EntryView: View {
    
    @State private var entryTitle: String = ""
    @State private var entryBody: String = ""
    @FocusState private var isEditorFocused: Bool
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Journal Entry")
                    .font(.title)
                    .padding(.bottom, 10)
                    
                TextField("Title", text: $entryTitle)
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 15)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Body")
                    .font(.headline)
                
                TextEditor(text: $entryBody)
                    .font(.body)
                    .frame(maxWidth: 500, minHeight: 200)
                    .padding(10)
                    .background(Color(.textBackgroundColor))
                    .focused($isEditorFocused)
                    .cornerRadius(8)
                    .overlay() {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isEditorFocused ? Color.accentColor : Color.gray.opacity(0.3), lineWidth: isEditorFocused ? 2 : 1)
                }
                    .lineSpacing(10)
                    .font(.system(size: 16, weight: .regular, design: .default))
            }
            
            HStack {
                Button("Save Entry", systemImage: "square.and.arrow.down", action: saveEntry)
            }
        }
        .formStyle(.grouped)
    }
    
//    Functions
//    TODO: Build out SaveEntry function, put export function in view to keep it localized to the view
    
    private func saveEntry() {
        
    }
}

#Preview {
    EntryView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
