//
//  RandomNumberView.swift
//  StateVSObserved
//
//  Created by Dongik Song on 11/13/24.
//

import SwiftUI

struct RandomNumberView: View {
    @State var randomNumber = 0

    var body: some View {
        VStack {
            Text("Random number is: \(randomNumber)")
            Button("Randomize number") {
                randomNumber = (0..<1000).randomElement()!
            }
        }.padding(.bottom)

        CounterView()
    }
}

#Preview {
    RandomNumberView()
}
