//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Dongik Song on 12/4/24.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    let formatter = ISO8601DateFormatter()
    var daysSinceLastAcitivity: Int {
        calculateDaysSinceLastActivity(from: repo.pushedAt)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    if #available(iOS 18.0, *) {
                        Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(named: "avatar")!)
                            .resizable()
                            .widgetAccentedRenderingMode(.accentedDesaturated)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(named: "avatar")!)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                        .widgetAccentable()
                }
                .padding(.bottom, 6)
                
                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(daysSinceLastAcitivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(daysSinceLastAcitivity > 50 ? .pink : .green)
                    .contentTransition(.numericText())
                    .widgetAccentable()
                Text("days ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .containerBackground(for: .widget) {}
        
    }
    
    func calculateDaysSinceLastActivity(from dateString: String) -> Int {
        let lastActivityDate = formatter.date(from: dateString) ?? .now
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
        return daysSinceLastActivity
    }
}


//struct Static_Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        RepoMediumView(repo: MockData.repoOne)
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}

//#Preview(as: .systemMedium) {
//    DoubleRepoWidget()
//} timeline: {
//    DoubleRepoEntry(date: .now, topRepo: MockData.repoOne, bottomRepo: MockData.repoTwo)
//}

fileprivate struct StatLabel: View {
    
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
                .contentTransition(.numericText())
                .widgetAccentable()
        } icon: {
            Image(systemName: systemImageName)
                .foregroundStyle(.green)
        }
        .fontWeight(.medium)
    }
}
