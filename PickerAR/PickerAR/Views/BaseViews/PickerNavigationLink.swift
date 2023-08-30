//
//  PickerNavigationLink.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 24.08.2023.
//

import SwiftUI

struct PickerNavigationLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    let isActive: Binding<Bool>?

    init(destination: Destination, isActive: Binding<Bool>? = nil, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        self.isActive = isActive
    }

    var body: some View {
        if let isActive = isActive {
            NavigationLink(destination: destination, isActive: isActive, label: { label })
                .isDetailLink(false)
                .navigationBarTitle("", displayMode: .inline)
        } else {
            NavigationLink(destination: destination, label: { label })
                .isDetailLink(false)
                .navigationBarTitle("", displayMode: .inline)
        }
    }
}
