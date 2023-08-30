//
//  PlacementButtonViews.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 01.08.2023.
//

import RealityKit
import SwiftUI

struct ConfirmButtonView: View {
    @Binding var selectedEntity: ModelEntity?
    @Binding var entityConfirmedForPlacement: ModelEntity?
    @Binding var canBePlaced: Bool
    var didTappedEdit: () -> Void
    
    var editButton: some View {
        Button(action: {
            didTappedEdit()
        }) {
            image(withSystemName: "pencil")
        }
    }
    
    var cancelButton: some View {
        Button(action: {
            resetPlacementParameters()
        }) {
            image(withSystemName: "xmark")
        }
    }
    
    var confirmButton: some View {
        Button(action: {
            guard canBePlaced else { return }
            entityConfirmedForPlacement = selectedEntity
            resetPlacementParameters()
        }) {
            image(withSystemName: "checkmark")
        }
    }
    
    private func image(withSystemName systemName: String) -> some View {
        Image(systemName: systemName)
            .frame(width: 60, height: 60)
            .font(.title)
            .background(.white)
            .cornerRadius(8)
            .padding(20)
            .foregroundColor(.blue)
    }
    
    var body: some View {
        HStack {
            editButton
            
            if selectedEntity != nil {
                cancelButton
                confirmButton
            }
        }
    }
    
    func resetPlacementParameters() {
        selectedEntity = nil
    }
}
