//
//  CartView.swift
//  ApiCart
//
//  Created by Dongik Song on 11/14/24.
//

import SwiftUI

struct CoreCartView: View {
    
    @ObservedObject var cartViewModel: CartViewModel
    
    @State private var isDelete = false
    @State private var currentCartItem: Cart?
    
    var body: some View {
        VStack {
            List {
                ForEach(cartViewModel.cart, id: \.self) { cart in
                    HStack {
                        Text(cart.title ?? "")
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
                    if let item = currentCartItem {
                        cartViewModel.deleteData(object: item)
                    }
                }
                Button("취소", role: .cancel) {}
            } message: {
                Text("이 항목을 삭제하시겠습니까?")
            }
        }
        .onAppear {
            cartViewModel.fetchRequest()
        }
    }
}
