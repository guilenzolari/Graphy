import SwiftUI

struct SelectionView: View {
    @State private var selectedAlgorithm: AlgorithmType = .none
    
    let viewModel: SelectionViewModel
    let callback: (_ selection: AlgorithmType) -> Void
    
    var body: some View {
        Picker("Selecione o algoritmo", selection: binding(for: $selectedAlgorithm)) {
            ForEach(AlgorithmType.allCases) { algorithm in
                Text(algorithm.rawValue).tag(algorithm)
            }
        }.pickerStyle(MenuPickerStyle())
    }
    
    private func binding(for selection: Binding<AlgorithmType>) -> Binding<AlgorithmType> {
        return Binding<AlgorithmType>(
            get: { selection.wrappedValue },
            set: { newValue in
                selection.wrappedValue = newValue
                callback(newValue)
            }
        )
    }
}

