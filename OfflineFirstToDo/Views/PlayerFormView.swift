//
//  PlayerFormView.swift
//  OfflineFirstToDo
//
//  Created by Edwin Cardenas on 11/15/26.
//

import SwiftUI

struct PlayerFormView: View {
    private enum FocusElement {
        case name
        case score
    }

    @Binding var form: PlayerForm
    @FocusState private var focusedElement: FocusElement?

    var body: some View {
        Group {
            LabeledContent {
                TextField(text: $form.name) { EmptyView() }
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .focused($focusedElement, equals: .name)
                    .labelsHidden()
                    .onSubmit {
                        focusedElement = .score
                    }
            } label: {
                Text("Name").foregroundStyle(.secondary)
            }

            LabeledContent {
                TextField(value: $form.score, format: .number) { EmptyView() }
                    .keyboardType(.numberPad)
                    .focused($focusedElement, equals: .score)
                    .labelsHidden()
            } label: {
                Text("Score").foregroundStyle(.secondary)
            }
        }
        .onAppear { focusedElement = .name }
    }
}

// MARK: - Previews

#Preview("Prefilled") {
    Form {
        PlayerFormView(form: .constant(PlayerForm(name: "John", score: 100)))
    }
}

#Preview("Empty") {
    Form {
        PlayerFormView(form: .constant(PlayerForm(name: "")))
    }
}
