//
//  ActionSheetViewModel.swift
//  NavigationModel
//
//  Created by Manish on 17/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

/// A model use to present action sheet on any view
///
/// For example
///
///     @State private var actionVM: ActionSheetViewModel?
///
///     Button("Action View") {
///         self.actionVM = ActionSheetViewModel(title: "title", message: "message", onCancel: nil)
///     }.actionSheet($actionVM)
///
@available(iOS 13.0, *)
public struct ActionSheetViewModel: Identifiable {
    
    public let id = 2
    let actionSheet: ActionSheet
    
    /// Intialize with give action sheet
    /// - Parameter actionSheet: ActionSheet to present
    public init(actionSheet: ActionSheet) {
        self.actionSheet = actionSheet
    }
    
    /// Initialize with title, message and actions
    /// - Parameters:
    ///   - title: Title of Action sheet
    ///   - message: Message of ActionSheet
    ///   - buttons: List of ActionSheet.Button
    public init(title: String?, message: String?, buttons: [ActionSheet.Button]) {
        self.init(actionSheet: ActionSheet(title: Text(title ?? ""),
                                  message: message == nil ? nil : Text(message!),
                                  buttons: buttons))
    }
    
    /// Initialize with title, message and cancel Action
    /// - Parameters:
    ///   - title: Title of Action sheet
    ///   - message: Message of ActionSheet
    ///   - onCancel: Cancel action handler
    public init(title: String?, message: String?, onCancel: (() -> Void)? = nil) {
        let cancel = ActionSheet.Button.cancel { onCancel?() }
        self.init(title: title, message: message, buttons: [cancel])
    }
    
    /// Initialize with title message and custom buttons
    /// - Parameters:
    ///   - title: Title of Action sheet
    ///   - message: Message of ActionSheet
    ///   - buttons: List of ActionSheet.Button
    ///   - onCancel: Cancel action handler
    public init(title: String?, message: String?, buttons: [ActionSheet.Button], onCancel: (() -> Void)? = nil) {
        let cancel = ActionSheet.Button.cancel { onCancel?() }
        var allButtons = buttons
        allButtons.append(cancel)
        self.init(title: title, message: message, buttons: allButtons)
    }
    
}

// MARK:- ActionSheet View Modifier
@available(iOS 13.0, *)
public extension View {
    
    /// View modifier for action sheet
    /// - Parameter model: Binding model ActionSheetViewModel
    /// - Returns: view with action sheet
    func actionSheet(_ model: Binding<ActionSheetViewModel?>) -> some View {
        actionSheet(item: model) { $0.actionSheet }
    }
    
    func navigate(_ model: Binding<ActionSheetViewModel?>) -> some View {
        actionSheet(model)
    }
}
