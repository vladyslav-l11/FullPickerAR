//
//  ModelPickerView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 24.08.2023.
//

import SwiftUI

struct ModelPickerView: View {
    var didPickerModel: (ObjectItems) -> Void
    private let models: [ObjectItems] = ObjectItems.allCases
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 30) {
                    ForEach(models, id: \.self) { value in
                        Button(action: {
                            didPickerModel(value)
                        }) {
                            Image(uiImage: value.image)
                                .resizable()
                                .frame(height: 80)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white)
                                .cornerRadius(12)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            .background(Color.black.opacity(0.5))
        }
    }
}
