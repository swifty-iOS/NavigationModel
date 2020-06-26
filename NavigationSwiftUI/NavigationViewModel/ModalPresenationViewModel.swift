//
//  ModalPresenationViewModel.swift
//  FBSwiftUI
//
//  Created by Manish on 24/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

struct ModalPresenationViewModel {
    
    var destination: AnyView
    
    init<Content>(destination: Content) where Content: View {
        self.destination = AnyView(destination)
    }
}

struct ModalPresenationViewModifier: ViewModifier {
    
    @ObservedObject private var viewModel: ModalPresentationMode
    
    init(model: Binding<ModalPresenationViewModel?>) {
        self.viewModel = ModalPresentationMode(model: model)
    }
    
    func body(content: Content) -> some View {
        content
    }
}

class ModalPresentationMode: ObservableObject {
    
    @Binding private var model: ModalPresenationViewModel?
    var animation = false
    private weak var viewController: UIViewController?

    init(model: Binding<ModalPresenationViewModel?>) {
        self._model = model
        if let view = model.wrappedValue?.destination  {
            let vc = UIHostingController(rootView: view.environmentObject(self))
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = .clear
          //  AppDelegate.shared.visibleViewController?.present(vc, animated: animation)
            viewController = vc
        }
    }
    
    func dimiss() {
        model = nil
        viewController?.dismiss(animated: animation, completion: nil)
    }
    
}

extension View {
    
    func modal(_  model: Binding<ModalPresenationViewModel?>) -> some View {
        modifier(ModalPresenationViewModifier(model: model))
    }
    
}
