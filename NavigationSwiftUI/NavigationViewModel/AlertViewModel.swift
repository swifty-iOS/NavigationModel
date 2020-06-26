//
//  AlertViewModel.swift
//  FBSwiftUI
//
//  Created by Manish on 16/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

struct AlertViewModel: Identifiable {
    
    var id = UUID()
    
    private(set) var alert: Alert
    
    init(title: String?, message: String?, onDismiss: (() -> Void)? = nil) {
        
        let okButton = Alert.Button.default(Text("OK")) { onDismiss?() }
        self.alert = Alert(title: Text(title ?? ""),
                           message: message == nil ? nil : Text(message!),
                           dismissButton: okButton)
    }
    
    init(title: String?, message: String?, primaryButton: Alert.Button, secondaryButton: Alert.Button) {
        self.alert = Alert(title: Text(title ?? ""),
                           message: message == nil ? nil : Text(message!),
                           primaryButton: primaryButton,
                           secondaryButton: secondaryButton)
    }
}

// MARK:- Alert with view model
extension View {
    
    func alert(_ model: Binding<AlertViewModel?>) -> some View {
        alert(item: model) { $0.alert }
    }
}
