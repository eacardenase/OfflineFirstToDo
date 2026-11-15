//
//  PlayersScreen.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayersScreen: View {
    @Environment(\.appDatabase) var appDatabase

    var body: some View {
        ContentView(appDatabase: appDatabase)
    }
}

private struct ContentView: View {
    @State var viewModel: PlayerListViewModel
    @State var editMode = EditMode.inactive
    @State var presentCreationSheet = false

    init(appDatabase: AppDatabase) {
        _viewModel = State(
            initialValue: PlayerListViewModel(appDatabase: appDatabase)
        )
    }

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
    PlayersScreen()
        .appDatabase(.random())
}

#Preview("Empty") {
    PlayersScreen()
        .appDatabase(.empty())
}
