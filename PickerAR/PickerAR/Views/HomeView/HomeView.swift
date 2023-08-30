//
//  HomeView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 23.08.2023.
//

import SwiftUI
import RealityKit
import ARKit

struct HomeView: View {
    private enum C {
        static let buttonsHeight: CGFloat = 48
        static let spacing: CGFloat = 20
    }
    
    @State private var shouldShowAlert = false
    @State private var shouldShowChooseObjectView = false
    @State private var shouldShowSkeletonView = false
    @State private var shouldShowObjectView = false
    @State private var entity: ModelEntity?
    
    var objectButton: some View {
        button(withTitle: "Object") { shouldShowChooseObjectView = true }
    }
    
    var skeletonButton: some View {
        button(withTitle: "Skeleton") {
            shouldShowSkeletonView = ARBodyTrackingConfiguration.isSupported
            shouldShowAlert = !ARBodyTrackingConfiguration.isSupported
        }
        .alert(R.string.localizable.notSupportSkeleton(), isPresented: $shouldShowAlert) {}
    }
    
    private func text(withTitle title: String) -> some View {
        Text(title)
            .frame(maxWidth: .infinity, minHeight: C.buttonsHeight)
            .foregroundColor(.blue)
            .background(.white)
    }
    
    private func button(withTitle title: String,
                        action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            text(withTitle: title)
        })
        .cornerRadius(8)
        .clipped()
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.gray.ignoresSafeArea()
                    VStack(spacing: C.spacing) {
                        PickerNavigationLink(destination: ChooseObjectView() {
                            entity = $0
                            shouldShowObjectView = true
                            shouldShowChooseObjectView = false
                        },
                                             isActive: $shouldShowChooseObjectView) { EmptyView() }
                        PickerNavigationLink(destination: SkilletView(),
                                             isActive: $shouldShowSkeletonView) { EmptyView() }
                        PickerNavigationLink(destination: ObjectView(selectedEntity: $entity),
                                             isActive: $shouldShowObjectView) { EmptyView() }
                        
                        objectButton
                        skeletonButton
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, geometry.size.width / 4)
                }
            }
            .accentColor(.white)
        }
    }
}
