//
//  PlayerCreationSheet.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayerCreationSheet: View {
    @Environment(\.appDatabase) var appDatabase
    @Environment(\.dismiss) var dismiss
    @State var form = PlayerForm(name: "")

    var body: some View {
        NavigationStack {
            Form {
                PlayerFormView(form: $form)
            }
            .navigationTitle("New Player")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        save()
                    }
                }
            }
        }
    }

    private func save() {
        var player = Player(name: form.name, score: form.score ?? 0)

        try? appDatabase.savePlayer(&player)

        dismiss()
    }
}

#Preview {
    PlayerCreationSheet()
}
