//
//  MainView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/7/26.
//

import SwiftUI

enum NavigationDestination: Hashable {
    case entryEditor
    case listEntries
    case exportView
}

struct MainView: View {
    @State private var navigationPath = NavigationPath()
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
                GridRow {
                    CardButtonView(title: "Create New Entry", icon: "pencil") {
                        navigate(to: .entryEditor)
                    }
                        .padding()
                    CardButtonView(title: "Export", icon: "square.and.arrow.up") {
                        navigate(to: .exportView)
                    }
                        .padding()
                }
                GridRow {
                    CardButtonView(title: "List Entries", icon: "list.dash") {
                        navigate(to: .listEntries)
                    }
                        .padding()
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .entryEditor:
                    EntryEditorView(entry: JournalEntry(creationDate: Date(), title: "", content: ""))
                case .listEntries:
                        ListEntryView()
                case .exportView:
                    ExportEntryToFileView(entriesToExport: nil)
                        
                }
            }
        }
        
    }
    
    // TODO: Define functions that call views based on card selection
    private func navigate(to destination: NavigationDestination) {
        navigationPath.append(destination)
    }
}


#Preview {
    MainView()
}
