//
//  ToggleOrderingButton.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct ToggleOrderingButton: View {
    @Binding var ordering: PlayerListViewModel.Ordering

    var body: some View {
        Button {
            ordering = ordering == .byName ? .byScore : .byName
        } label: {
            HStack {
                Text(ordering == .byName ? "Name" : "Score")
                Image(
                    systemName: ordering == .byName
                        ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
                )
                .imageScale(.medium)
            }
        }
    }
}
