//
//  AlertViewModel.swift
//  NavigationModel
//
//  Created by Manish on 16/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

/// A model use to present alert on any view
///
/// For example
///
///     @State private var alertVM: AlertViewModel?
///
///     Button("Alert View") {
///         self.alertVM = AlertViewModel(title: "title", message: "Message")
///     }.alert($alertVM)
///
@available(iOS 13.0, *)
public struct AlertViewModel: Identifiable {
    
    public let id = 0
    let alert: Alert
    
    /// Intialize with given Alert
    /// - Parameter alert: Alert to show
    public init(alert: Alert) {
        self.alert = alert
    }
    
    /// Intialize with given details
    /// - Parameters:
    ///   - title: Title of alert
    ///   - message: Message of Alert
    ///   - onDismiss: Dismiss action handler
    public init(title: String?, message: String?, onDismiss: (() -> Void)? = nil) {
        
        let okButton = Alert.Button.default(Text("OK")) { onDismiss?() }
        self.init(alert: Alert(title: Text(title ?? ""),
                           message: message == nil ? nil : Text(message!),
                           dismissButton: okButton))
    }
    
    /// Intialize with given details
    /// - Parameters:
    ///   - title: Title of alert
    ///   - message: Message of Alert
    ///   - primaryButton: Alert.Button
    ///   - secondaryButton: Alert.Button
    public init(title: String?, message: String?, primaryButton: Alert.Button, secondaryButton: Alert.Button) {
        self.init(alert: Alert(title: Text(title ?? ""),
                           message: message == nil ? nil : Text(message!),
                           primaryButton: primaryButton,
                           secondaryButton: secondaryButton))
    }
    
}

// MARK:- Alert View Modifier
@available(iOS 13.0, *)
public extension View {
    
    /// Modify view to show AlertViewModel
    /// - Parameter model: Bindable AlertViewModel
    /// - Returns: View with alert
    func alert(_ model: Binding<AlertViewModel?>) -> some View {
        alert(item: model) { $0.alert }
    }
    
    func navigate(_ model: Binding<AlertViewModel?>) -> some View {
        alert(model)
    }
    
}
