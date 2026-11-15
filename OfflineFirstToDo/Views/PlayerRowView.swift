//
//  PlayerRowView.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayerRowView: View {
    let player: Player

    var body: some View {
        HStack {
            Group {
                if player.name.isEmpty {
                    Text("Anonymous").italic()
                } else {
                    Text(player.name)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(player.score) points")
                .monospacedDigit()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PlayerRowView(player: .makeRandom())
}
