import SwiftUI

@main
struct SearchAlgorithmApp: App {
    var body: some Scene {
        WindowGroup {
            AlgorithmView(viewModel: AlgorithmViewModel(algorithm: .init()))
        }
    }
}
