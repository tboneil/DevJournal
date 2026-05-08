//
//  MainView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/7/26.
//

import SwiftUI

enum NavigationDestination: Hashable {
    case entryEditor
    case quickEntry
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
                    // Place cards here
                    CardButtonView(title: "Quick Entry", icon: "pencil") {
                        navigate(to: .quickEntry)
                    }
                        .padding()
                    CardButtonView(title: "List Entries", icon: "list.dash") {
                        navigate(to: .listEntries)
                    }
                        .padding()
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .entryEditor:
                    EntryEditorView()
                case .quickEntry:
                    QuickEntryView()
                case .listEntries:
                    // TODO: Create list view
                    MainView()
                case .exportView:
                    // TODO: Create export view function
                    MainView()
                        
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
