//
//  ObjectView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 14.08.2023.
//

import RealityKit
import SwiftUI
import Combine

struct ObjectView: View {
    @Binding var selectedEntity: ModelEntity?
    @State private var entityConfirmedForPlacement: ModelEntity?
    @State private var shouldOpenChooseView = false
    @State private var canBePlaced = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            PickerNavigationLink(destination: ChooseObjectView(shouldGoBack: true) { selectedEntity = $0 },
                                 isActive: $shouldOpenChooseView) { EmptyView() }
            
            ObjectARViewContainer(entityConfirmedForPlacement: $entityConfirmedForPlacement,
                                  canBePlaced: $canBePlaced)
                .edgesIgnoringSafeArea(.all)
            
            ConfirmButtonView(selectedEntity: $selectedEntity,
                              entityConfirmedForPlacement: $entityConfirmedForPlacement,
                              canBePlaced: $canBePlaced) {
                shouldOpenChooseView = true
            }
        }
    }
}
