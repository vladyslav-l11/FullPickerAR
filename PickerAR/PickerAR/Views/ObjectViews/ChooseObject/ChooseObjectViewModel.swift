//
//  ChooseObjectViewModel.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 24.08.2023.
//

import UIKit
import RealityKit
import Combine

final class ChooseObjectViewModel: ObservableObject {
    @Published var entity: ModelEntity?
    private var cancellable: AnyCancellable?
    
    func getEntity(withURL url: URL, completion: @escaping () -> Void) {
        cancellable = ModelEntity.loadModelAsync(contentsOf: url)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] in
                guard let self = self else { return }
                self.entity = $0
                completion()
            })
    }
}
