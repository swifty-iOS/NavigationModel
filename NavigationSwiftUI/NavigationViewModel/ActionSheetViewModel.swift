//
//  SwiftUIView.swift
//  FBSwiftUI
//
//  Created by Manish on 17/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

struct ActionSheetViewModel: Identifiable {
    
    internal let id = UUID()
    
    let actionSheet: ActionSheet
    
    init(title: String?, message: String?, buttons: [ActionSheet.Button]) {
        actionSheet = ActionSheet(title: Text(title ?? ""),
                                  message: message == nil ? nil : Text(message!),
                                  buttons: buttons)
    }
    
    init(title: String?, message: String?, onCancel: (() -> Void)? = nil) {
        let cancel = ActionSheet.Button.cancel { onCancel?() }
        self.init(title: title, message: message, buttons: [cancel])
    }
    
    init(title: String?, message: String?, buttons: [ActionSheet.Button], onCancel: (() -> Void)?) {
        
        let cancel = ActionSheet.Button.cancel { onCancel?() }
        var allButtons = buttons
        allButtons.append(cancel)
        self.init(title: title, message: message, buttons: allButtons)
    }
    
}

extension View {
    
    func actionSheet(_ model: Binding<ActionSheetViewModel?>) -> some View {
        actionSheet(item: model) { $0.actionSheet }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    struct ActionSheetViewModel_Test: View {
        
        @State var actionSheetModel: ActionSheetViewModel?
        
        var body: some View {
            return VStack {
                Button("Style 1") {
                    self.actionSheetModel = ActionSheetViewModel(title: "Test", message: nil)
                }
                
                Button("Style 2") {
                    self.actionSheetModel = ActionSheetViewModel(title: "Test", message: "Message")
                }
                
                Button("Style 3") {
                    let button1 = ActionSheet.Button.default(Text("Action 1"))
                    let button2 = ActionSheet.Button.destructive(Text("Action 2"))
                    
                    self.actionSheetModel = ActionSheetViewModel(title: "Test", message: "Message",
                                                                 buttons: [button1, button2])
                }
                
                Button("Style 4") {
                    let button1 = ActionSheet.Button.default(Text("Action 1"))
                    let button2 = ActionSheet.Button.destructive(Text("Action 2"))
                    
                    self.actionSheetModel = ActionSheetViewModel(title: "Test", message: "Message",
                                                                 buttons: [button1, button2], onCancel: nil)
                }
                
            }.actionSheet($actionSheetModel)
        }
    }
    
    static var previews: some View {
        
        ActionSheetViewModel_Test()
    }
}
