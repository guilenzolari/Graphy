import SwiftUI

struct SelectionView: View {
    @State private var selectedAlgorithm: AlgorithmType = .none
    
    let viewModel: SelectionViewModel
    let callback: (_ selection: AlgorithmType) -> Void
    
    var body: some View {
        Picker("Selecione", selection: binding(for: $selectedAlgorithm)) {
            ForEach(AlgorithmType.allCases) { algorithm in
                Text(algorithm.rawValue).tag(algorithm)
            }
        }.pickerStyle(.menu)
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

#Preview {
    SelectionView(viewModel: SelectionViewModel(algorithm: AlgorithmModel()), callback: {selection in })
}
