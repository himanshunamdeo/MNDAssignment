//
//  TimerView.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 14/11/24.
//

import SwiftUI

struct TimerView: View {
    
    let timerFont: Font = .custom(CustomFontNames.HelveticaNeue, size: 40).bold()
    var body: some View {
        HStack {
            Text("01")
                .font(timerFont)
                .foregroundColor(.white)
            Text(":")
                .font(timerFont)
                .foregroundColor(.white)
            Text("00")
                .font(timerFont)
                .foregroundColor(.white)
            Text(":")
                .font(timerFont)
                .foregroundColor(.white)
            Text("0000")
                .font(timerFont)
                .foregroundColor(.white)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
