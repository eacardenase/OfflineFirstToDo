//
//  PlayerEditView.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayerEditView: View {
    @Environment(\.isPresented) var isPresented
    @Environment(\.appDatabase) var appDatabase
    @State var form: PlayerForm

    init(player: Player) {
        self._form = State(
            initialValue: PlayerForm(name: player.name, score: player.score)
        )
    }

    var body: some View {
        Form {
            PlayerFormView(form: $form)
        }
        .navigationTitle(form.name)
        .onChange(of: isPresented) {
            if !isPresented {
                save()
            }
        }
    }

    private func save() {
        var player = Player(name: form.name, score: form.score ?? 0)

        try? appDatabase.savePlayer(&player)
    }
}

#Preview {
    NavigationStack {
        PlayerEditView(player: .makeRandom())
    }
}
