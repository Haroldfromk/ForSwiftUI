//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Dongik Song on 12/4/24.
//

import WidgetKit
import SwiftUI

struct CompactRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> CompactRepoEntry {
        CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CompactRepoEntry) -> ()) {
        let entry = CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            
            do {
                // Get Top Repo
                var repo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.google)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                // Get Bottom Repo if in Large Widget
                var bottomRepo: Repository?
                if context.family == .systemLarge {
                    bottomRepo = try await NetworkManager.shared.getRepo(atUrl: RepoURL.swiftAlgorithms)
                    let avatarImageData = await NetworkManager.shared.downloadImageData(from: bottomRepo!.owner.avatarUrl)
                    bottomRepo!.avatarData = avatarImageData ?? Data()
                }
                
                // Create Entry & TimeLine
                let entry = CompactRepoEntry(date: .now, repo: repo, bottomRepo: bottomRepo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate)) // update every 12hours
                completion(timeline)
            }
            catch {
                print("❌ Error - \(error.localizedDescription)")
            }

        }
    }
    
    //    func relevances() async -> WidgetRelevances<Void> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct CompactRepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let bottomRepo: Repository?
}

struct CompactRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: CompactRepoProvider.Entry
    
    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
                .containerBackground(for: .widget) {}
        case .systemLarge:
            VStack(spacing: 76) {
                RepoMediumView(repo: entry.repo)
                if let bottomRepo = entry.bottomRepo {
                    RepoMediumView(repo: bottomRepo)
                }
            }
            .containerBackground(for: .widget) {}
        case .systemSmall, .systemExtraLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
}

struct CompactRepoWidget: Widget {
    let kind: String = "CompactRepoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CompactRepoProvider()) { entry in
            CompactRepoEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Repo Watcher")
        .description("Keep an eye on one or two Github.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

#Preview(as: .systemLarge) {
    CompactRepoWidget()
} timeline: {
    CompactRepoEntry(date: .now, repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
}


