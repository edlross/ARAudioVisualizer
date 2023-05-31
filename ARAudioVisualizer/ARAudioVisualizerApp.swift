import SwiftUI

@main
struct ARAudioVisualizer: App {
    @StateObject var coordinator = ViewCoordinator()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(coordinator)
        }
    }
}
