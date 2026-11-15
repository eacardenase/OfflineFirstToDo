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
    @Bindable var viewModel: PlayerViewModel

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
        var player = Player(name: viewModel.name, score: viewModel.score ?? 0)

        try? appDatabase.savePlayer(&player)

        dismiss()
    }
}

#Preview {
    NavigationStack {
        PlayerEditView(viewModel: .init(name: "Edwin", score: 100))
    }
}
