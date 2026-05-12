//
//  MainDetailView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/11/26.
//

import SwiftUI

enum NavigationDestinations: Hashable {
    case journalEntry
    case exportEntries
}

struct MainDetailView: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
                GridRow {
                    MainDetailButtonView(
                        title: "Create New Entry",
                        icon: "pencil",
                        action: { navigate(to: .journalEntry) }
                    )
                    .padding()
                    
                    MainDetailButtonView(
                        title: "Export",
                        icon: "square.and.arrow.up",
                        action: { navigate(to: .exportEntries) }
                    )
                    .padding()
                }
            }
            .padding()
            .navigationTitle("Dev Journal")
            .navigationDestination(for: NavigationDestinations.self) { destination in
                switch destination {
                case .journalEntry:
                    EntryView()
                        .navigationTitle("New Entry")
                case .exportEntries:
                    Text("Export View")
                        .navigationTitle("Export")
                }
            }
        }
    }
    
    private func navigate(to destination: NavigationDestinations) {
        navigationPath.append(destination)
    }
}

#Preview {
    MainDetailView()
}
