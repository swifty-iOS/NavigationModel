//
//  ModalPresentationViewModel.swift
//  NavigationModel
//
//  Created by Manish on 24/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

public struct ModalPresentationViewModel {
    
    let destination: AnyView
    weak var source: UIViewController?
    
    public init<Content>(source: UIViewController, destination: Content) where Content: View {
        self.destination = AnyView(destination)
        self.source = source
    }
    
    public init<Content>(source: UIViewController, @ViewBuilder content: () -> Content) where Content: View {
        self.init(source: source, destination: content())
    }
}

public final class ModalPresentationMode: ObservableObject {
    
    public var animation = false
    
    @Binding private var model: ModalPresentationViewModel?
    private weak var destinationVC: UIViewController?

    fileprivate init(model: Binding<ModalPresentationViewModel?>) {
        self._model = model
        if let view = model.wrappedValue?.destination  {
            let vc = UIHostingController(rootView: view.environmentObject(self))
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = .clear
            self.model?.source?.present(vc, animated: false)
            destinationVC = vc
        }
    }
    
    public func dimiss() {
        model = nil
        destinationVC?.dismiss(animated: animation, completion: nil)
    }
    
}

// MARK: ViewModifer for Preseting Transparent View
private struct ModalPresenationViewModifier: ViewModifier {
    
    @ObservedObject private var viewModel: ModalPresentationMode
    
    init(model: Binding<ModalPresentationViewModel?>) {
        self.viewModel = ModalPresentationMode(model: model)
    }
    
    func body(content: Content) -> some View {
        content
    }
}


public extension View {
    
    func modal(_  model: Binding<ModalPresentationViewModel?>) -> some View {
        modifier(ModalPresenationViewModifier(model: model))
    }
    
}
