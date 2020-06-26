//
//  SheetViewModel.swift
//  FBSwiftUI
//
//  Created by Manish on 18/05/2020.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

struct SheetViewModel: Identifiable {
    
    let id = UUID()
    private let _content: AnyView
    
    init<Content>(_ content: () -> Content) where Content: View {
        self.init(content())
    }
    
    init<Content>(_ content: Content) where Content: View {
        self._content = AnyView(content)
    }
    
    var content: some View {
        _content
    }

}

extension View {
    
    func sheet(_ model: Binding<SheetViewModel?>) -> some View {
        sheet(item: model) { $0.content }
    }
}

struct SheetViewModel_Previews: PreviewProvider {
    
    
    struct Demo: View {
        
        @State var sheetVM: SheetViewModel?
        
        var body: some View {
            Button("Show") {
                self.sheetVM = SheetViewModel { Text("Sheet") }
            }.sheet($sheetVM)
        }
    }
    
    static var previews: some View {
        Demo()
    }
}

