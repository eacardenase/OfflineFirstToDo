//
//  PlayersScreen.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayersScreen: View {
    @Bindable var viewModel: PlayerListViewModel
    @State var editMode = EditMode.inactive
    @State var presentCreationSheet = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.players.isEmpty {
                    ContentUnavailableView {
                        Label("The team is empty!", systemImage: "person.slash")
                    } actions: {
                        Button("Add Player") {
                            presentCreationSheet = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    PlayerListView(model: viewModel)
                        .toolbar {
                            ToolbarItemGroup(placement: .topBarLeading) {
                                Button {
                                    stopEditing()

                                    presentCreationSheet = true
                                } label: {
                                    Image(systemName: "plus")
                                }

                                EditButton()
                            }

                            ToolbarItem(placement: .topBarTrailing) {
                                ToggleOrderingButton(
                                    ordering: $viewModel.ordering
                                )
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        try? viewModel.deleteAllPlayers()
                    } label: {
                        Image(systemName: "trash")
                    }

                    Spacer()

                    Button {
                        Task {
                            stopEditing()

                            try? await viewModel.refreshPlayers()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
        .onAppear {
            viewModel.observePlayers()
        }
        .sheet(isPresented: $presentCreationSheet) {
            PlayerCreationSheet()
        }
    }

    private func stopEditing() {
        withAnimation {
            editMode = .inactive
        }
    }
}

#Preview("Populated") {
    PlayersScreen(viewModel: .init(appDatabase: .random()))
}

#Preview("Empty") {
    PlayersScreen(viewModel: .init(appDatabase: .empty()))
}
