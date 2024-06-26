import SwiftUI

struct HomeView: View {
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    
    let viewModel: HomeViewModel

    var body: some View {
        VStack {
            
            viewFactory.selectionView()
            
            VStack(spacing: 0) {
                viewFactory.gridView()
                Button(action: {
                    viewModel.clearSimulation()
                }, label: {
                    Text("Clear")
                })
                .padding()
                
            }
        }
        .navigationTitle("Algoritmos")
        .padding()
    }
}
