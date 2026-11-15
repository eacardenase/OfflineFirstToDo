//
//  PlayerRowView.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayerRowView: View {
    let viewModel: PlayerViewModel

    var body: some View {
        HStack {
            Group {
                if viewModel.name.isEmpty {
                    Text("Anonymous").italic()
                } else {
                    Text(viewModel.name)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(viewModel.score) points")
                .monospacedDigit()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PlayerRowView(viewModel: .init(name: "Edwin", score: 100))
}
