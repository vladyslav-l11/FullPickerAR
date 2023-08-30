//
//  SliderView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 19.08.2023.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    //var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Slider(value: $value, in: range)
                .tint(.white)
        }
    }
}
