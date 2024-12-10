//
//  WidgetModifiers.swift
//  SwiftCalWidgetExtension
//
//  Created by Dongik Song on 12/10/24.
//

import SwiftUI

struct DidStudyAccent: ViewModifier {
    let didStudy: Bool
    
    func body(content: Content) -> some View {
        if didStudy {
            if #available(iOS 16, *) {
                content.widgetAccentable()
            } else {
                content
            }
        } else {
            content
        }
    }
}

extension View {
    public func didStudyAccentable(_ didStudy: Bool) -> some View {
        modifier(DidStudyAccent(didStudy: didStudy))
    }
}
