//
//  RepoWatcherWidgetBundle.swift
//  RepoWatcherWidget
//
//  Created by Dongik Song on 12/4/24.
//

import WidgetKit
import SwiftUI

//@main
struct RepoWatcherWidgetBundle: WidgetBundle {
    var body: some Widget {
        //DoubleRepoWidget()
        RepoWatcherWidgetControl()
        RepoWatcherWidgetLiveActivity()
    }
}
