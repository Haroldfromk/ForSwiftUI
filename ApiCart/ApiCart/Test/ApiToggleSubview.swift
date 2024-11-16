//
//  ApiToggleSubview.swift
//  ApiCart
//
//  Created by Dongik Song on 11/17/24.
//

import SwiftUI

struct ApiToggleSubview: View {
    let useStateObject: Bool
    @ObservedObject var cartViewModel: CartViewModel

    @StateObject private var stateViewModel: TestWishViewModel
    @ObservedObject private var observedViewModel: TestWishViewModel

    init(useStateObject: Bool, cartViewModel: CartViewModel) {
        self.useStateObject = useStateObject
        self.cartViewModel = cartViewModel

        // 초기화 시점에서 선택적으로 인스턴스를 생성
        if useStateObject {
            _stateViewModel = StateObject(wrappedValue: TestWishViewModel())
            _observedViewModel = ObservedObject(wrappedValue: TestWishViewModel()) // 더미 인스턴스
        } else {
            _stateViewModel = StateObject(wrappedValue: TestWishViewModel()) // 더미 인스턴스
            _observedViewModel = ObservedObject(wrappedValue: TestWishViewModel())
        }
    }

    var body: some View {
        VStack {
            Text(useStateObject ? "StateObject - API 조회" : "ObservedObject - API 조회")
                .font(.headline)

            let viewModel = useStateObject ? stateViewModel : observedViewModel

            if let item = viewModel.wishList.first {
                HStack {
                    Text(item.title)
                    Spacer()
                    Button("담기") {
                        cartViewModel.addCart(model: item)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
            }

            Button("API 조회") {
                Task {
                    await viewModel.fetchWishList()
                }
            }
            .padding()
        }
    }
}
