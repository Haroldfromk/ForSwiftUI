//
//  CounterView.swift
//  StateVSObserved
//
//  Created by Dongik Song on 11/13/24.
//

import SwiftUI

final class CounterViewModel: ObservableObject {
    @Published var count = 0

    func incrementCounter() {
        count += 1
    }
}

struct CounterView: View {
    @ObservedObject var viewModel = CounterViewModel()
    //@StateObject var viewModel = CounterViewModel()
    
    var body: some View {
        VStack {
            Text("Count is: \(viewModel.count)")
            Button("Increment Counter") {
                viewModel.incrementCounter()
            }
        }
    }

}
#Preview {
    CounterView()
}
