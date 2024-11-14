//
//  CountdownDialView.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 14/11/24.
//

import SwiftUI

struct CountdownDialView: View {
    
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            
            // Dial Path circle
            Circle()
                .stroke(Color.AppParrotGreen.opacity(0.2), lineWidth: 10)
            
            // Dial Progress Circle
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(Color.AppParrotGreen,
                        style: StrokeStyle(lineWidth: 20,
                                           lineCap: .round))
                .rotationEffect(.degrees(-90))
                
            
        }
    }
}

struct CountdownDialView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownDialView(progress: .constant(0.3))
    }
}
