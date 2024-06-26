import SwiftUI

struct AlgorithmSelectionView: View {
    @State private var selectedAlgorithm: AlgorithmType = .none
    let viewModel: AlgorithmViewModel
    
    var body: some View {
        Picker("Selecione o algoritmo desejado", selection: $selectedAlgorithm) {
            ForEach(AlgorithmType.allCases) { algorithm in
                Text(algorithm.rawValue).tag(algorithm)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .onChange(of: selectedAlgorithm) { newAlgorithm in
            viewModel.startSimulation(for: newAlgorithm)
        }
    }
}
