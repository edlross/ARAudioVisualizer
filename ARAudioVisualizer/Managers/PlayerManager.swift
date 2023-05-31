import AudioKit
import SwiftUI

class PlayerManager {
    let engine = AudioEngine()
    var name: String = ""
    
    var player: AudioPlayer?
    var duration: Double { player?.duration ?? 0.0 }

    init(name: String, url: URL) {
        self.name = name
        
        self.player = AudioPlayer(url: url)
        self.player?.isLooping = false
    }
}
