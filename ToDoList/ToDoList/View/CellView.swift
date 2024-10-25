//
//  CellView.swift
//  ToDoList
//
//  Created by Dongik Song on 10/21/24.
//

import SwiftUI

struct CellView: View {
    @State var isOn: Bool = false
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
                .strikethrough(isOn, color: .red)
                .padding(.leading, 10)
                .lineLimit(0)
            Toggle("", isOn: $isOn)
                .padding(.trailing, 10)
                .tint(.green)
        }
    }
}

#Preview {
    CellView(title: "test")
}
