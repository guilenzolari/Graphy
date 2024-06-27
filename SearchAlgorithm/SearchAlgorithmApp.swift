import SwiftUI

@main
struct SearchAlgorithmApp: App {
    
    @AppStorage("hasOnboardingCompleted") private var hasOnboardingCompleted = false
    
    @State private var isPresentingOnboarding = false
    
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                viewFactory.homeView()
                    .sheet(
                        isPresented: Binding<Bool>(
                            get: {
                                !hasOnboardingCompleted },
                            set: { _ in }
                        ),
                        
                        content: {
                            OnboardingView(
                                onboardingCompleted: $hasOnboardingCompleted
                            ).interactiveDismissDisabled()
                        })
                    .onAppear {
                        isPresentingOnboarding = true
                    }
            }
        }
    }
}
