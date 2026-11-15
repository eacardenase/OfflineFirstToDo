//
//  PlayerListView.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayerListView: View {
    @Bindable var model: PlayerListViewModel

    var body: some View {
        List {
            ForEach(model.players, id: \.id) { player in
                NavigationLink {
                    PlayerEditView(player: player)
                } label: {
                    PlayerRowView(player: player)
                }
            }
            .onDelete { offsets in
                try? model.deletePlayers(at: offsets)
            }
        }
        .animation(.default, value: model.players)
        .listStyle(.plain)
        .navigationTitle("\(model.players.count) Players")
    }
}

#Preview {
    @Previewable @State var model = PlayerListViewModel(appDatabase: .random())

    NavigationStack {
        PlayerListView(model: model)
    }
    .onAppear {
        model.observePlayers()
    }
}
