//
//  GameWidgetBundle.swift
//  GameWidget
//
//  Created by Dongik Song on 12/11/24.
//

import WidgetKit
import SwiftUI

@main
struct GameWidgetBundle: WidgetBundle {
    var body: some Widget {
        GameWidget()
        if #available(iOS 16.1, *) {
            GameLiveActivity()
        }
    }
}
