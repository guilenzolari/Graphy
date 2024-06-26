import SwiftUI

struct AlgorithmView: View {
    let viewModel: AlgorithmViewModel

    var body: some View {
        VStack {
            
            AlgorithmSelectionView(viewModel: viewModel)
            
            VStack(spacing: 0) {
                GridView(viewModel: viewModel)
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
