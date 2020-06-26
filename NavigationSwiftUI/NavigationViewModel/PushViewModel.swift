//
//  PushViewModel.swift
//  FBSwiftUI
//
//  Created by Manish on 24/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

struct PushViewModel {
    
    var destination: AnyView
    
    init<Content>(destination: Content) where Content: View {
        self.destination = AnyView(destination)
    }
    
}


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
extension View {
    
    func push(_ model: Binding<PushViewModel?>) -> some View {
        modifier(PushViewModifier(model: model))
    }
}
