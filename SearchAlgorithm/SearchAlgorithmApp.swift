import SwiftUI

@main
struct SearchAlgorithmApp: App {
    
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    
    var body: some Scene {
        WindowGroup {
            viewFactory.homeView()
        }
    }
}
