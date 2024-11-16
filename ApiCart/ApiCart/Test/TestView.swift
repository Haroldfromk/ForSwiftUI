//
//  TestView.swift
//  ApiCart
//
//  Created by Dongik Song on 11/15/24.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var cartViewModel = CartViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                // ObservedObject 섹션
                VStack {
                    ApiToggleSubview(useStateObject: false, cartViewModel: cartViewModel)
                        .frame(height: 180)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                // StateObject 섹션
                VStack {
                    ApiToggleSubview(useStateObject: true, cartViewModel: cartViewModel)
                        .frame(height: 180)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)

                // 장바구니 내용 섹션
                VStack {
                    Text("장바구니 내용")
                        .font(.headline)

                    List(cartViewModel.cart, id: \.self) { item in
                        Text(item.title ?? "No Title")
                    }
                    .frame(height: 150)

                    Button("장바구니 초기화") {
                        cartViewModel.deleteAllData()
                    }
                    .padding(.vertical, 5)
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}
