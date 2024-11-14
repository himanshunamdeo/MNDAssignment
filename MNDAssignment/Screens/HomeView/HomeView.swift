//
//  HomeView.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 14/11/24.
//

import SwiftUI

struct HomeView: View {
    @State var progress: CGFloat = 0.5
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
                
                ZStack {
                    CountdownDialView(progress: $progress)
                        .padding(30)
                    
                    TimerView()
                }
                
                Spacer()
                
                ControlPanel()
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


