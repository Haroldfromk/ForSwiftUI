//
//  WidgetBundle.swift
//  RepoWatcherWidgetExtension
//
//  Created by Dongik Song on 12/4/24.
//


import WidgetKit
import SwiftUI

@main
struct RepoWatcherWidgets: WidgetBundle {
    var body: some Widget {
        CompactRepoWidget()
        ContributorWidget()
    }
}
