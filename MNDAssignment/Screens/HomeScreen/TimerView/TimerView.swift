//
//  TimerView.swift
//  MNDAssignment
//
//  Created by MeTaLlOiD on 14/11/24.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject private var viewModel: TimerViewModel
    let timerFont: Font = .custom(CustomFontNames.HelveticaNeue, size: 40).bold()
    
    @Binding var isStarted: Bool
    @Binding var isStopped: Bool
    @Binding var progressTracker: CGFloat
    
    
    init(viewModel: TimerViewModel, isStarted: Binding<Bool>, isStopped: Binding<Bool>, progressTracker: Binding<CGFloat>) {
        self.viewModel = viewModel
        self._isStarted = isStarted
        self._isStopped = isStopped
        self._progressTracker = progressTracker
    }
    
    var body: some View {
        HStack {
            Text(viewModel.minute)
                .font(timerFont)
                .foregroundColor(.white)
            Text(":")
                .font(timerFont)
                .foregroundColor(.white)
            Text(viewModel.second)
                .font(timerFont)
                .foregroundColor(.white)
            Text(":")
                .font(timerFont)
                .foregroundColor(.white)
            Text(viewModel.milliSecond)
                .font(timerFont)
                .foregroundColor(.white)
        }
        .onChange(of: isStarted) { newValue in
            if newValue == true {
                self.viewModel.startTimer()
            } else {
                self.viewModel.pauseTimer()
            }
        }
        .onChange(of: isStopped) { newValue in
            if newValue == true {
                self.viewModel.stopTimer()
                self.isStarted = false
                self.isStopped = false
            }
        }
        .onReceive(viewModel.$progressTracker) { newValue in
            self.progressTracker = newValue
            
            // pause after the progress completes
            if progressTracker <= 0.0 {
                isStarted.toggle()
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: TimerViewModel(timerService: ThrottledTimerService()), isStarted: .constant(false), isStopped: .constant(false), progressTracker: .constant(0.0))
    }
}
