//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Dongik Song on 12/4/24.
//

import WidgetKit
import SwiftUI

struct DoubleRepoProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DoubleRepoEntry {
        DoubleRepoEntry(date: Date(), topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
    }
    func getSnapshot(for configuration: SelectTwoReposIntent, in context: Context, completion: @escaping @Sendable (DoubleRepoEntry) -> Void) {
        let entry = DoubleRepoEntry(date: Date(), topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
        completion(entry)
    }
    func getTimeline(for configuration: SelectTwoReposIntent, in context: Context, completion: @escaping @Sendable (Timeline<DoubleRepoEntry>) -> Void) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            
            do {
                // Get Top Repo
                var topRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.prefix + configuration.topRepo!)
                let topAvatarImageData = await NetworkManager.shared.downloadImageData(from: topRepo.owner.avatarUrl)
                topRepo.avatarData = topAvatarImageData ?? Data()
                
                // Get Bottom Repo if in Large Widget
                var bottomRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.prefix + configuration.bottomRepo!)
                let bottomAvatarImageData = await NetworkManager.shared.downloadImageData(from: bottomRepo.owner.avatarUrl)
                bottomRepo.avatarData = bottomAvatarImageData ?? Data()
                
                // Create Entry & TimeLine
                let entry = DoubleRepoEntry(date: .now, topRepo: topRepo, bottomRepo: bottomRepo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate)) // update every 12hours
                completion(timeline)
            }
            catch {
                print("❌ Error - \(error.localizedDescription)")
            }
            
        }
    }
    
}

struct DoubleRepoEntry: TimelineEntry {
    let date: Date
    let topRepo: Repository
    let bottomRepo: Repository
}

struct DoubleRepoEntryView : View {
    var entry: DoubleRepoProvider.Entry
    
    var body: some View {
        VStack(spacing: 76) {
            RepoMediumView(repo: entry.topRepo)
            RepoMediumView(repo: entry.bottomRepo)
        }
    }
}

struct DoubleRepoWidget: Widget {
    let kind: String = "DoubleRepoWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectTwoReposIntent.self, provider: DoubleRepoProvider()) { entry in
            DoubleRepoEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Repo Watcher")
        .description("Keep an eye two Github repositories.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    DoubleRepoWidget()
} timeline: {
    DoubleRepoEntry(date: .now, topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
}


