//
//  HomeView.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 14/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var progress: CGFloat = 0.5
    @State var isStopped: Bool = false
    @State var isStarted: Bool = false
    
    var body: some View {
        ZStack {
            
            RadialGradient(colors: [Color.AppBlueGreen, Color.AppPurple],
                           center: .center,
                           startRadius: 1,
                           endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
                
                Text("COUNT DOWN")
                    .font(.custom(CustomFontNames.HelveticaNeue, size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.AppLightGreen)
                    .padding(.top)
                
                Spacer()
                
                // Timer UI with progress
                ZStack {
                    CountdownDialView(progress: $progress)
                        .padding(30)
                    
                    TimerView(viewModel: TimerViewModel(timerService: ThrottledTimerService()), isStarted: $isStarted, isStopped: $isStopped, progressTracker: $progress)
                }
                
                Spacer()
                
                // Start/Pause and Stop Button panel
                ControlPanel(isStarted: $isStarted, isStopped: $isStopped)
                    .padding(.bottom)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


