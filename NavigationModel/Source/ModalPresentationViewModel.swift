//
//  ModalPresentationViewModel.swift
//  NavigationModel
//
//  Created by Manish on 24/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

/// A model use to Presnt a view on full sccreen with tansparent background
///
/// It requires source ViewController which is currently visible on window. You can get it from SceneDelegate / AppDelegate.
/// To close modally preseted use must use ModalPresentationMode envirnoment object in presented view.
///
/// For example
///
///     @State private var modalVM: ModalPresentationViewModel?
///
///     var body: some View {
///
///      Button("Present Modal View") {
///          if let source = SceneDelegate.shared.window?.rootViewController {
///              self.modalVM = ModalPresentationViewModel(source: source,
///                                                       destination: Text("New to View"))
///      }
///
///     }.modal($modalVM)
///
@available(iOS 13.0, *)
public struct ModalPresentationViewModel {
    
    let destination: AnyView
    weak var source: UIViewController?
    
    /// Intialize with source and destiation
    /// - Parameters:
    ///   - source: Current  visible View Controller on window
    ///   - destination: View to present modally
    public init<Content>(source: UIViewController, destination: Content) where Content: View {
        self.destination = AnyView(destination)
        self.source = source
    }
    
    /// Intialize with source and destiation
    /// - Parameters:
    ///   - source: Current  visible View Controller on window
    ///   - destination: View to present modally
    public init<Content>(source: UIViewController, @ViewBuilder content: () -> Content) where Content: View {
        self.init(source: source, destination: content())
    }
}

// MARK:- ModalPresentationMode

/// This is presentation mode for Modally presented view. Must use to dismiss the presented controller
///
/// For example
///
///         @EnvironmentObject var presenationMode: ModalPresentationMode
///
///         Text("Close").onTap {
///             self.presenationMode.dismiss()
///         }
///
@available(iOS 13.0, *)
public final class ModalPresentationMode: ObservableObject {
    
    /// Call this method to close modally presented view.
    public func dimiss() {
        model = nil
        destinationVC?.dismiss(animated: false, completion: nil)
    }
    
    // MARK: -Private use only
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
}

// MARK: ViewModifer for Preseting Transparent View
@available(iOS 13.0, *)
private struct ModalPresenationViewModifier: ViewModifier {
    
    @ObservedObject private var viewModel: ModalPresentationMode
    
    init(model: Binding<ModalPresentationViewModel?>) {
        self.viewModel = ModalPresentationMode(model: model)
    }
    
    func body(content: Content) -> some View {
        content
    }
}

@available(iOS 13.0, *)
public extension View {
    
    /// Modify view with given model to Present
    /// - Parameter model: Bindable object of ModalPresentationViewModel
    /// - Returns: modified view with givem model
    func modal(_  model: Binding<ModalPresentationViewModel?>) -> some View {
        modifier(ModalPresenationViewModifier(model: model))
    }
    
    func navigate(_  model: Binding<ModalPresentationViewModel?>) -> some View {
        modal(model)
    }
    
}
