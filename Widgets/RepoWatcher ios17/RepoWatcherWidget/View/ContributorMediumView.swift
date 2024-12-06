//
//  ContributorMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Dongik Song on 12/5/24.
//

import SwiftUI

struct ContributorMediumView: View {
    let repo: Repository
    
    var body: some View {
        VStack {
            HStack {
                Text("Top Contributors")
                    .font(.caption).bold()
                    .foregroundStyle(.secondary)
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2),
                      alignment: .leading,
                      spacing: 20) {
                ForEach(repo.contributors) { contributor in
                    HStack {
                        Image(uiImage: UIImage(data: contributor.avataData) ?? UIImage(named: "avatar")!)
                            .resizable()
                            .widgetAccentedRenderingMode(.desaturated)
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(contributor.login)
                                .font(.caption)
                                .minimumScaleFactor(0.7)
                            Text("\(contributor.contributions)")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                //.contentTransition(.numericText())
                                .id(repo.name)
                                .transition(.push(from: .trailing))
                        }
                    }
                }
            }
            if repo.contributors.count < 3 {
                Spacer().frame(height: 20)
            }
        }
    }
}


//#Preview(as: .systemMedium) {
//    ContributorWidget()
//} timeline: {
//    ContributorEntry(date: .now, repo: MockData.repoOne)
//}
