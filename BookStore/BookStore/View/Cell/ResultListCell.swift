//
//  ResultListCell.swift
//  BookStore
//
//  Created by Dongik Song on 11/25/24.
//

import SwiftUI

struct ResultListCell: View {
    @State var title: String = "title"
    @State var author: String = "author"
    @State var price: Int = 0
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 13))
                .lineLimit(0)
            Spacer()
            Text(author)
                .font(.system(size: 8))
            Spacer()
            Text(price.toString())
                .font(.system(size: 10))
        }
    }
}

#Preview {
    ResultListCell(title: "미움받을 용기", author: "기시미 이치로, 고가 후미타케", price: 14900)
}
