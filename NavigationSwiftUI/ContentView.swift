//
//  ContentView.swift
//  NavigationSwiftUI
//
//  Created by Manish Bhande on 26/06/20.
//  Copyright © 2020 Manish Bhande. All rights reserved.
//

import SwiftUI
import NavigationModel

struct ContentView: View {
    
    
    var body: some View {
        NavigationView {
            VStack {
                TestPush()
                TestSheet()
                TestAlert()
                TestActionSheet()
                
            }
            .navigationBarTitle("Navigation Type")
        }
    }
}

// MARK: Push
struct TestPush: View {
    
    @State private var pushVM: PushViewModel?
    
    var body: some View {
        Button("Push View") {
            self.pushVM = PushViewModel(destination: Text("New view pushed."))
        }.push($pushVM)
    }
}

// MARK: Alert
struct TestAlert: View {
    
    @State private var alertVM: AlertViewModel?
    
    var body: some View {
        
        Button("Alert View") {
            self.alertVM = AlertViewModel(title: "Test Alert", message: "Alert message here.")
            }
        .alert($alertVM)
      // .navigate($alertVM)
    }
}

// MARK: Sheet
struct TestSheet: View {
    
    @State private var sheetVM: SheetViewModel?
    
    var body: some View {
        Button("Present Sheet") {
            self.sheetVM = SheetViewModel(Text("New presented sheet."))
        }.sheet($sheetVM)
    }
}

// MARK:- Actio sheet
struct TestActionSheet: View {
    
    @State private var actionSheetVM: ActionSheetViewModel?
    
    var body: some View {
        
        Button("Action Sheet") {
            self.actionSheetVM = ActionSheetViewModel(title: "Action Title", message: "Action message", buttons: [.default(Text("Option 1")), .default(Text("Option 2")), .cancel()])
        }.actionSheet($actionSheetVM)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
