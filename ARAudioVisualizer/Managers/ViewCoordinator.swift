import SwiftUI

class ViewCoordinator: ObservableObject {
    @Published var playbackState: PlaybackState = .stopped
    
    var playerManager = PlayerManager(name: "Demo Song", url: Bundle.main.url(forResource: "DemoSong", withExtension: "wav")!)
    var instruments: Instruments.Music?
    
    init() {
        playerManager.engine.output = playerManager.player
        do { try playerManager.engine.start() } catch {
            print("Couldn't start engine")
        }
    }
    
    func screenTapped() {
        switch playbackState {
        case .playing:
            playbackState = .paused
        case .paused, .stopped:
            playbackState = .playing
        }
    }
    
    func playbackChanged() {
        switch playbackState {
        case .playing:
            playerManager.player?.play()
        case .paused:
            playerManager.player?.pause()
        case .stopped:
            playerManager.player?.stop()
        }
    }
    
    func cursorUpdated(time: Double) {
        guard let instruments = instruments else { return }
        
        switch time {
        case 0.0...0.1:
            if playbackState == .playing { instruments.notifications.emphasizeDrum.post() }
        case 6.0...6.1:
            instruments.notifications.emphasizeTrumpet.post()
        case 16.0...16.1:
            instruments.notifications.emphasizeGuitar.post()
        case playerManager.duration...(playerManager.duration + 0.1):
            playbackEnded()
            return
        default:
            break
        }
    }
    
    func screenLongPressed() { playbackEnded() }
    func playbackEnded() {
        playbackState = .stopped
        playerManager.player?.stop()
    }
}
