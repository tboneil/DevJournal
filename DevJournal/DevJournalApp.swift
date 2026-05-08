//
//  DevJournalApp.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/5/26.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct DevJournalApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [JournalEntry.self])
    }
}

extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.item-document")
    }
}



struct DevJournalMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        DevJournalVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct DevJournalVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        JournalEntry.self
    ]
}
