//
//  AppDatabase.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/14/26.
//

import Foundation
import GRDB
import os.log

struct AppDatabase: Sendable {
    private let dbWriter: any DatabaseWriter

    init(_ dbWriter: any DatabaseWriter) throws {
        self.dbWriter = dbWriter

        try migrator.migrate(dbWriter)
    }

    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        #if DEBUG
            migrator.eraseDatabaseOnSchemaChange = true
        #endif

        migrator.registerMigration("v1") { db in
            try db.create(table: "player") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("score", .integer).notNull()
            }
        }

        return migrator
    }
}

// MARK: - Database Configuration

extension AppDatabase {
    private static let sqlLogger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "SQL"
    )

    static func makeConfiguration(
        _ config: Configuration = Configuration()
    ) -> Configuration {
        var config = config

        #if DEBUG
            config.publicStatementArguments = true
        #endif

        return config
    }
}

// MARK: - Database Access: Writes

extension AppDatabase {
    func savePlayer(_ player: inout Player) throws {
        try dbWriter.write { db in
            try player.save(db)
        }
    }

    func deletePlayers(ids: [Int64]) throws {
        try dbWriter.write { db in
            _ = try Player.deleteAll(db, keys: ids)
        }
    }

    func deleteAllPlayers() throws {
        try dbWriter.write { db in
            _ = try Player.deleteAll(db)
        }
    }

    func createRandomPlayersIfEmpty() throws {
        try dbWriter.write { db in
            if try Player.all().isEmpty(db) {
                try createRandomPlayers(db)
            }
        }
    }

    private func createRandomPlayers(_ db: Database) throws {
        for _ in 0..<8 {
            _ = try Player.makeRandom().inserted(db)
        }
    }
}

// MARK: - Database Access: Reads

extension AppDatabase {
    var reader: any GRDB.DatabaseReader {
        dbWriter
    }
}
