//
//  LiveActivityView.swift
//  GameWidgetExtension
//
//  Created by Dongik Song on 12/11/24.
//

import SwiftUI
import WidgetKit

struct LiveActivityView: View {
    @Environment(\.isActivityFullscreen) var isStandby
    
    let context: ActivityViewContext<GameAttributes>
    
    var body: some View {
        ZStack {
            if !isStandby {
                Image("activity-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        ContainerRelativeShape()
                            .fill(.black.opacity(0.7).gradient)
                    }
                    .contentTransition(.identity)
            }
            
            
            VStack(spacing: 12) {
                HStack {
                    Image(context.attributes.homeTeam)
                        .teamLogoModifier(frame: 60)
                        .contentTransition(.identity)
                    
                    Text("\(context.state.gameState.homeScore)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white.opacity(0.7))
                        .contentTransition(.numericText())
                    
                    Spacer()
                    
                    Text("\(context.state.gameState.awayScore)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(isStandby ? .white : .black.opacity(0.8))
                        .contentTransition(.numericText())
                    
                    Image(context.attributes.awayTeam)
                        .teamLogoModifier(frame: 60)
                        .contentTransition(.identity)
                }
                
                HStack {
                    Image(context.state.gameState.scoringTeamName)
                        .teamLogoModifier(frame: 20)
                    
                    Text(context.state.gameState.lastAction)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .padding()
        }
        
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiveActivityView()
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//            .containerBackground(for: .widget) { }
//    }
//}
