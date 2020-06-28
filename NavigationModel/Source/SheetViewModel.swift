//
//  SheetViewModel.swift
//  NavigationModel
//
//  Created by Manish on 18/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

/// A model use to present Sheet on view from any view
///
/// For example
///
///     @State private var sheetVM: SheetViewModel?
///
///     Button("Present Sheet") {
///         self.sheetVM = SheetViewModel(Text("New presented sheet."))
///     }.sheet($sheetVM)
///
@available(iOS 13.0, *)
public struct SheetViewModel: Identifiable {
    
    public let id = 1
    let content: AnyView
    
    /// Initialize view model given content
    /// - Parameter content: some View
    public init<Content>(_ content: Content) where Content: View {
        self.content = AnyView(content)
    }
    
    /// Initialize view model given content
    /// - Parameter content: some View
    public init<Content>(@ViewBuilder content: () -> Content) where Content: View {
        self.init(content())
    }
    
}

// MARK:- Sheet View Modifier
@available(iOS 13.0, *)
public extension View {
    
    /// Modify view to present sheet
    /// - Parameter model: Binding<SheetViewModel?>
    /// - Returns: modifed view having sheet
    func sheet(_ model: Binding<SheetViewModel?>) -> some View {
        sheet(item: model) { $0.content }
    }
    
    func navigate(_ model: Binding<SheetViewModel?>) -> some View {
        sheet(model)
    }
}
