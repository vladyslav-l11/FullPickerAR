//
//  SkilletView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 14.08.2023.
//

import SwiftUI

struct SkilletView: View {
    @State private var jointHue: Double = 0
    @State private var jointRadius: Double = 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                SkileltARViewContainer(jointHue: $jointHue, jointRadius: $jointRadius)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Image(uiImage: R.image.ic_rainbow()!)
                            .resizable()
                            .frame(width: geometry.size.width - 32, height: 24)
                            .aspectRatio(contentMode: .fit)
                    }
                    SliderView(value: $jointHue, range: 0...1)
                    Text("Joint Size")
                        .multilineTextAlignment(.leading)
                    SliderView(value: $jointRadius, range: 1...2)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
