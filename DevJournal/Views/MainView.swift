//
//  MainView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/7/26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        // TODO: Add in NavigationSplitMenu with links for some other abilities
        
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            GridRow {
                CardButtonView(title: "Create New Entry", icon: "pencil", action: {})
                    .padding()
                CardButtonView(title: "Export", icon: "square.and.arrow.up", action: {})
                    .padding()
            }
            GridRow {
                // Place cards here
                CardButtonView(title: "Quick Entry", icon: "pencil", action: {})
                    .padding()
                CardButtonView(title: "List Entries", icon: "list.dash", action: {})
                    .padding()
            }
        }
        
    }
}

// TODO: Define functions that call views based on card selection

private func callEntryEditorView() {
    
}

private func callQuickEntryView() {
    
}

private func callListView() {
    
}

private func callExportView() {
    
}

#Preview {
    MainView()
}
