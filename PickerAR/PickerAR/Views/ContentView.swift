//
//  ContentView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 23.07.2023.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
