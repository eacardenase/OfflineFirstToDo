//
//  OfflineFirstToDoApp.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/14/26.
//

import SwiftUI

@main
struct OfflineFirstToDoApp: App {
    var body: some Scene {
        WindowGroup {
            PlayersScreen()
                .appDatabase(.shared)
        }
    }
}

extension EnvironmentValues {
    @Entry var appDatabase = AppDatabase.empty()
}

extension View {
    func appDatabase(_ appDatabase: AppDatabase) -> some View {
        self.environment(\.appDatabase, appDatabase)
    }
}
