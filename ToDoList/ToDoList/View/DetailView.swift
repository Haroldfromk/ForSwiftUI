//
//  DetailView.swift
//  ToDoList
//
//  Created by Dongik Song on 10/24/24.
//

import SwiftUI

struct DetailView: View {
    var title: String = ""
    
    var body: some View {
        Text(title)
    }
}

#Preview {
    DetailView(title: "test")
}
