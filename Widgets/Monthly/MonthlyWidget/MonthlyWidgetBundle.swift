//
//  MonthlyWidgetBundle.swift
//  MonthlyWidget
//
//  Created by Dongik Song on 12/3/24.
//

import WidgetKit
import SwiftUI

@main
struct MonthlyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MonthlyWidget()
        MonthlyWidgetControl()
        MonthlyWidgetLiveActivity()
    }
}
