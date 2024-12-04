//
//  ContentView.swift
//  Actor
//
//  Created by Dongik Song on 12/2/24.
//

import SwiftUI

/*
class Counter {
    var value = 0

    func increment() -> Int {
        value += 1
        return value
    }
}
*/

class Counter {
    var value = 0

    func increment() -> Int {
        value += 1
        return value
    }
}

struct ContentView: View {
    var body: some View {
        Button {
            let counter = Counter()
            DispatchQueue.concurrentPerform(iterations: 100) { _ in
//                Task {
//                    print(await counter.increment())
//                }
                print(counter.increment())
            }
        } label: {
            Text("Increment")
        }

    }
}

#Preview {
    ContentView()
}
