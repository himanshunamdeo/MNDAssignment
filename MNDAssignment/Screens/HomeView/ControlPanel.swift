//
//  ControlPanel.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 14/11/24.
//

import SwiftUI

struct ControlPanel: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: ScreenDimestion.width/1.5, height: ScreenDimestion.height/6)
                .foregroundColor(.AppLightGreen.opacity(0.3))
            
            HStack {
                
                Spacer()
                Button (action: {
                    // action
                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 40)
                }
                .padding(.trailing, 30)
                
                

                Button (action: {
                    // action
                }) {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(width: 40)
                }
                .padding(.leading, 30)
                
                Spacer()
            }
        }
    }
}

struct ControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanel()
    }
}
