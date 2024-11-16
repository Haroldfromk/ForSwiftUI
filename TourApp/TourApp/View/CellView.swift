//
//  CellView.swift
//  TourApp
//
//  Created by Dongik Song on 11/4/24.
//

import SwiftUI

struct CellView: View {
    var title: String
    var imageUrl: String
    
    var body: some View {
        HStack {
            Image(systemName: imageUrl)
                .font(.system(size: 30))
                
            
            Text(title)
                .fontWeight(.semibold)
                .padding(.leading, 10)
                .lineLimit(0)
        }
    }
}

#Preview {
    CellView(title: "test", imageUrl: "star")
}
