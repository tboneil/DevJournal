//
//  EntryEditorView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/6/26.
//

import SwiftUI


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
        }
        .formStyle(.grouped)
    }
}

#Preview {
    EntryEditorView()
}
