//
//  SwiftCalControl.swift
//  SwiftCalWidgetExtension
//
//  Created by Dongik Song on 12/10/24.
//

import SwiftUI
import WidgetKit


struct SwiftCalControl: ControlWidget {
    let kind: String = "SwiftCalControl"
    
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: kind) {
            ControlWidgetToggle(<#T##title: StringProtocol##StringProtocol#>,
                                isOn: <#T##Bool#>,
                                action: <#T##SetValueIntent#>,
                                valueLabel: <#T##(Bool) -> View#>)
        }
        
        StaticControlConfiguration(kind: kind) {
            ControlWidgetToggle("Study Swift",
                                isOn: Persistence.currentDay?.didStudy ?? false,
                                action: ControlToggleStudyIntent()) { isOn in
                Label(isOn ? "Studied Swift" : "Study Swift",
                      systemImage: isOn ? "checkmark.circle" : "swift")
            }
                                .tint(.orange)
        }
        .displayName("Swift Study Today")
        .description("Mark that you studied Swift today.")
    }
}
