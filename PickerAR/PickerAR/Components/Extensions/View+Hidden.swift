//
//  View+Hidden.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 15.08.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self
        } else {
            self.hidden()
        }
    }
}
