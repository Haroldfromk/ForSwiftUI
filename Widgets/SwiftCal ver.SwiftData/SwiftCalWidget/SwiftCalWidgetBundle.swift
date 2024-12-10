//
//  SwiftCalWidgetBundle.swift
//  SwiftCalWidget
//
//  Created by Dongik Song on 12/9/24.
//

import WidgetKit
import SwiftUI

@main
struct SwiftCalWidgetBundle: WidgetBundle {
    var body: some Widget {
        SwiftCalWidget()
        SwiftCalControl()
    }
}
