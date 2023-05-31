import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var coordinator: ViewCoordinator
    
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var cursor: Double = 0.0
    
    var body: some View {
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
                .onAppear { coordinator.playbackState = .stopped }
            
            VStack {
                Text(coordinator.playerManager.name)
                    .font(.title)
                Text(cursor.minuteSecond)
                    .font(.headline)
                
                Spacer()
            }
            
            Image(systemName: coordinator.playbackState == .playing ? "pause" : "play")
                .font(.title3)
                .fontWeight(.heavy)
        }
        .onTapGesture { coordinator.screenTapped() }
        .onLongPressGesture { coordinator.screenLongPressed() }
        .onReceive(timer) { _ in updateCursor() }
        .onChange(of: cursor) { playbackTime in coordinator.cursorUpdated(time: playbackTime) }
        .onChange(of: coordinator.playbackState) { state in playbackStateChanged(state: state) }
    }
    
    func updateCursor() {
        if coordinator.playbackState == .playing { cursor += 0.01 }
    }
    
    func playbackStateChanged(state: PlaybackState) {
        coordinator.playbackChanged()
        
        switch state {
        case .playing:
            timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        case .paused:
            timer.upstream.connect().cancel()
        case .stopped:
            timer.upstream.connect().cancel()
            cursor = 0.0
        }
        print(state)
    }
}
