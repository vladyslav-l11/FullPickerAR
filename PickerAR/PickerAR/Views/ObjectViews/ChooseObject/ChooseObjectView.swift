//
//  ChooseObjectView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 24.08.2023.
//

import SwiftUI
import RealityKit

struct ChooseObjectView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var openFile = false
    @StateObject private var viewModel = ChooseObjectViewModel()
    
    var shouldGoBack = false
    var didGoBackWithEntity: ((ModelEntity) -> Void)?
    
    init(shouldGoBack: Bool = false,
         didGoBackWithEntity: ((ModelEntity) -> Void)? = nil) {
        self.shouldGoBack = shouldGoBack
        self.didGoBackWithEntity = didGoBackWithEntity
    }
    
    var loadButton: some View {
        Button(action: {
            openFile = true
        }, label: {
            Text("Load File")
                .frame(maxWidth: .infinity, minHeight: 48)
                .foregroundColor(.white)
        })
        .background(.mint)
        .cornerRadius(8)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white, lineWidth: 2)
        )
        .padding(.horizontal, 32)
        .fileImporter(isPresented: $openFile,
                      allowedContentTypes: [.usdz],
                      allowsMultipleSelection: false) {
            guard let fileURL = (try? $0.get())?.first else { return }
            _ = fileURL.startAccessingSecurityScopedResource()
            viewModel.getEntity(withURL: fileURL) {
                handleEntityFetch()
            }
        }
    }
    
    private func handleEntityFetch() {
        guard let entity = viewModel.entity else { return }
        didGoBackWithEntity?(entity)
        if shouldGoBack {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(R.string.localizable.chooseTheModel())
                ModelPickerView {
                    viewModel.getEntity(withURL: $0.modelURL) {
                        handleEntityFetch()
                    }
                }
                Text(R.string.localizable.chooseOr())
                Text(R.string.localizable.useFilesWithExtension())
                loadButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.gray)
    }
}
