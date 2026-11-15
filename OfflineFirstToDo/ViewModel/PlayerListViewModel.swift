//
//  PlayerListViewModel.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import Foundation
import GRDB
import Observation

@Observable
class PlayerListViewModel {
    enum Ordering {
        case byName
        case byScore
    }

    var players = [Player]()
    private let appDatabase: AppDatabase
    @ObservationIgnored private var cancellable: AnyDatabaseCancellable?

    var ordering: Ordering = .byScore {
        didSet { observePlayers() }
    }

    // MARK: - Initializers

    init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }

    // MARK: - Observation

    func observePlayers() {
        let observation = ValueObservation.tracking { [ordering] db in
            switch ordering {
            case .byName:
                try Player.order {
                    $0.name.collating(.localizedCaseInsensitiveCompare)
                }
                .fetchAll(db)
            case .byScore:
                try Player.order {
                    [
                        $0.score.desc,
                        $0.name.collating(.localizedCaseInsensitiveCompare),
                    ]
                }
                .fetchAll(db)
            }
        }

        cancellable = observation.start(
            in: appDatabase.reader,
            scheduling: .immediate
        ) { error in
            // TODO: Handle error
        } onChange: { [unowned self] players in
            self.players = players
        }
    }

    // MARK: - Actions

    func deletePlayers(at offsets: IndexSet) throws {
        let playerIds = offsets.compactMap { players[$0].id }

        try appDatabase.deletePlayers(ids: playerIds)
    }

    func deleteAllPlayers() throws {
        try appDatabase.deleteAllPlayers()
    }
}
