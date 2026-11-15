//
//  Player.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/14/26.
//

import GRDB

struct Player: Equatable, Codable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?
    var name: String
    var score: Int
}

extension Player {
    private static let names = [
        "Arthur", "Anita", "Barbara", "Bernard", "Craig", "Chiara", "David",
        "Dean", "Éric", "Elena", "Fatima", "Frederik", "Gilbert", "Georgette",
        "Henriette", "Hassan", "Ignacio", "Irene", "Julie", "Jack", "Karl",
        "Kristel", "Louis", "Liz", "Masashi", "Mary", "Noam", "Nicole",
        "Ophelie", "Oleg", "Pascal", "Patricia", "Quentin", "Quinn", "Raoul",
        "Rachel", "Stephan", "Susie", "Tristan", "Tatiana", "Ursule", "Urbain",
        "Victor", "Violette", "Wilfried", "Wilhelmina", "Yvon", "Yann",
        "Zazie", "Zoé",
    ]

    static func new() -> Player {
        Player(id: nil, name: "", score: 0)
    }

    static func makeRandom() -> Player {
        Player(id: nil, name: randomName(), score: randomScore())
    }

    static func randomName() -> String {
        names.randomElement()!
    }

    static func randomScore() -> Int {
        10 * Int.random(in: 0...100)
    }
}

// MARK: - Database

extension Player {
    enum Columns {
        static let name = Column(CodingKeys.name)
        static let score = Column(CodingKeys.score)
    }

    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}
