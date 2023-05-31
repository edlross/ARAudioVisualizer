import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var coordinator: ViewCoordinator
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let music = try! Instruments.loadMusic()
        coordinator.instruments = music
        arView.scene.anchors.append(music)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
