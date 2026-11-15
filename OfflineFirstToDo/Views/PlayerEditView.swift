//
//  PlayerEditView.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayerEditView: View {
    @Environment(\.appDatabase) var appDatabase
    @Environment(\.dismiss) var dismiss
    @State var viewModel: PlayerViewModel
    var player: Player

    init(player: Player) {
        self.player = player
        _viewModel = State(
            initialValue: .init(name: player.name, score: player.score)
        )
    }

    var body: some View {
        Form {
            PlayerFormView(viewModel: viewModel)
        }
        .navigationTitle(viewModel.name)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    save()
                }
            }
        }
    }

    private func save() {
        var player = player

        player.name = viewModel.name
        player.score = viewModel.score ?? 0

        try? appDatabase.savePlayer(&player)

        dismiss()
    }
}

#Preview {
    NavigationStack {
        PlayerEditView(player: .init(name: "Edwin", score: 100))
    }
}
