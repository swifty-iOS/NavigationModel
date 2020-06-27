//
//  PushViewModel.swift
//  NavigationModel
//
//  Created by Manish on 24/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

/// A model use to push a view from any view (inside navigation view)
///
/// For example
///
///     @State private var pushVM: PushViewModel?
///
///     Button("Push View") {
///         self.pushVM = PushViewModel(destination: Text("New view pushed."))
///     }.push($pushVM)
///
public struct PushViewModel {
    
    let destination: AnyView
    
    /// Intiailize model with given Destiation View
    /// - Parameter destination: View to push
    public init<Content>(destination: Content) where Content: View {
        self.destination = AnyView(destination)
    }
    
    /// Intiailize model with given View
    /// - Parameter destination: View to push
    public init<Content>(@ViewBuilder destination: () -> Content) where Content: View {
        self.init(destination: destination())
    }
    
}

// MARK:- PushViewModifier
/// Keeps the track of presentation state
private struct PushViewModifier: ViewModifier {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(model: Binding<PushViewModel?>) {
        self.viewModel = ViewModel(model: model)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if viewModel.isActive {
                NavigationLink(destination: viewModel.pushModel?.destination, isActive: $viewModel.isActive) { EmptyView() }
            }
        }
    }
    
    // MARK:- ViewModel
    final class ViewModel: ObservableObject {
        
        @Binding var pushModel: PushViewModel?
        @Published var isActive: Bool { didSet { if !isActive { pushModel = nil } } }
        
        init(model: Binding<PushViewModel?>) {
            self._pushModel = model
            self.isActive = model.wrappedValue != nil
        }
    }
}

// MARK:- Push View Modifier
public extension View {
    
    /// Modify view with given model to push
    /// - Parameter model: Binding<PushViewModel?>
    /// - Returns: Modified view
    func push(_ model: Binding<PushViewModel?>) -> some View {
        modifier(PushViewModifier(model: model))
    }
    
    func navigate(_ model: Binding<PushViewModel?>) -> some View {
        push(model)
    }
}
