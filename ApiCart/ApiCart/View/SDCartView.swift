//
//  SDCartView.swift
//  ApiCart
//
//  Created by Dongik Song on 11/16/24.
//

import SwiftUI
import SwiftData

struct SDCartView: View {
    @StateObject var sdCartViewModel: SDCartViewModel
    
    @State private var isDelete = false
    @State private var currentCartItem: SDCartModel?
    
    var body: some View {
        VStack {
            List {
                ForEach(sdCartViewModel.cart, id: \.self) { cart in
                    HStack {
                        Text(cart.title)
                        Spacer()
                        Text(cart.price.dollarAdd())
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            currentCartItem = cart
                            isDelete.toggle()
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                    }
                }
            }
            .alert("항목 삭제", isPresented: $isDelete) {
                Button("삭제", role: .destructive) {
                    if let currentCartItem {
                        sdCartViewModel.deleteCart(object: currentCartItem)
                    }
                }
                Button("취소", role: .cancel) {}
            } message: {
                Text("이 항목을 삭제하시겠습니까?")
            }
        }
        .onAppear {
            sdCartViewModel.fetchRequest()
        }
    }
}
