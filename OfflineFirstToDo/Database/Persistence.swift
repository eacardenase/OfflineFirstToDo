//
//  Persistence.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/14/26.
//

import Foundation
import GRDB

extension AppDatabase {
    static let shared = makeShared()

    private static func makeShared() -> AppDatabase {
        do {
            let fileManager = FileManager()
            let appSupportURL = try fileManager.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let directoryURL = appSupportURL.appendingPathComponent(
                "Database",
                isDirectory: true
            )

            try fileManager.createDirectory(
                at: directoryURL,
                withIntermediateDirectories: true
            )

            let databaseURL = directoryURL.appendingPathComponent("db.sqlite")
            let config = AppDatabase.makeConfiguration()
            let dbPool = try DatabasePool(
                path: databaseURL.path,
                configuration: config
            )

            let appDatabase = try AppDatabase(dbPool)

            return appDatabase
        } catch {
            fatalError(
                "DEBUG: Failed to make shared AppDatabase with error: \(error)"
            )
        }
    }

    static func empty() -> AppDatabase {
        let dbQueue = try! DatabaseQueue(
            configuration: AppDatabase.makeConfiguration()
        )

        return try! AppDatabase(dbQueue)
    }

    static func random() -> AppDatabase {
        let appDatabase = empty()

        try! appDatabase.createRandomPlayersIfEmpty()

        return appDatabase
    }
}
