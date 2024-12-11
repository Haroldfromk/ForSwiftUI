//
//  GameWidgetLiveActivity.swift
//  GameWidget
//
//  Created by Dongik Song on 12/11/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct GameLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: GameAttributes.self) { context in
            // Lock screen/banner UI goes here
            LiveActivityView(context: context)
//                .activityBackgroundTint(Color.cyan)
//                .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Image(context.attributes.homeTeam)
                            .teamLogoModifier(frame: 40)
                            .contentTransition(.identity)
                        
                        Text("\(context.state.gameState.homeScore)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .contentTransition(.numericText())
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                        Text("\(context.state.gameState.awayScore)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .contentTransition(.numericText())
                        
                        Image(context.attributes.awayTeam)
                            .teamLogoModifier(frame: 40)
                            .contentTransition(.identity)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Image(context.state.gameState.scoringTeamName)
                            .teamLogoModifier(frame: 20)
                            .contentTransition(.identity)
                        
                        Text("\(context.state.gameState.lastAction)")
                    }
                }
            } compactLeading: {
                HStack {
                    Image(context.attributes.homeTeam)
                        .teamLogoModifier()
                        .contentTransition(.identity)
                    
                    Text("\(context.state.gameState.homeScore)")
                        .fontWeight(.semibold)
                        .contentTransition(.numericText())
                }
            } compactTrailing: {
                HStack {
                    Text("\(context.state.gameState.awayScore)")
                        .fontWeight(.semibold)
                        .contentTransition(.numericText())
                    
                    Image(context.attributes.awayTeam)
                        .teamLogoModifier()
                        .contentTransition(.identity)
                }
            } minimal: {
                // current winning team
                Image(context.state.gameState.winningTeamName)
                    .teamLogoModifier()
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//extension GameAttributes {
//    fileprivate static var preview: GameAttributes {
//        GameAttributes(name: "World")
//    }
//}
//
//extension GameAttributes.ContentState {
//    fileprivate static var smiley: GameAttributes.ContentState {
//        GameAttributes.ContentState(emoji: "😀")
//    }
//    
//    fileprivate static var starEyes: GameAttributes.ContentState {
//        GameAttributes.ContentState(emoji: "🤩")
//    }
//}

//#Preview("Notification", as: .content, using: GameAttributes.preview) {
//    GameLiveActivity()
//} contentStates: {
//    GameAttributes.ContentState.smiley
//    GameAttributes.ContentState.starEyes
//}
