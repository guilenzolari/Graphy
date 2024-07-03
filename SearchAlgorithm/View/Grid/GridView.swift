import SwiftUI

struct GridView: View {
    
    @State private var showAlert = false
    
    let viewModel: GridViewModel
    let nodeSelection: NodeSelection
    
    var body: some View {
        VStack {
            
            ForEach(1...viewModel.getRowSize, id: \.self) { i in
                HStack(spacing: 0) {
                    ForEach(1...viewModel.getColumnSize, id: \.self) { j in
                        let current = "\(i)-\(j)"
                        if viewModel.getPath.contains(current) {
                            Image(systemName: getFilledSymbol(for: current))
                                .font(.system(size: 34))
                                .foregroundStyle(getFilledColor(for: current))
                                .padding(.vertical, -6)
                                .padding(.horizontal, -4)
                                .onTapGesture {
                                    vibrate()
                                    if(nodeSelection.nodeType == .sourceNode) {
                                        vibrate()
                                        if(viewModel.algorithm.goalNode == current) {
                                            showAlert = true
                                        } else {
                                            viewModel.algorithm.sourceNode = current
                                        }
                                    } else if(nodeSelection.nodeType == .goalNode) {
                                        vibrate()
                                        if(viewModel.algorithm.sourceNode == current) {
                                            showAlert = true
                                        } else {
                                            viewModel.algorithm.goalNode = current
                                        }
                                    } else if(nodeSelection.nodeType == .emptyNode) {
                                        
                                    }
                                }
                    } else {
                            Image(systemName: getEmptySymbol(for: current))
                                .font(.system(size: 34))
                                .foregroundStyle(getEmptyColor(for: current))
                                .padding(.vertical, -6)
                                .padding(.horizontal, -4)
                                .onTapGesture {
                                    if(nodeSelection.nodeType == .sourceNode) {
                                        vibrate()
                                        if(viewModel.algorithm.goalNode == current) {
                                            showAlert = true
                                        } else {
                                            viewModel.algorithm.sourceNode = current
                                        }
                                    } else if(nodeSelection.nodeType == .goalNode) {
                                        vibrate()
                                        if(viewModel.algorithm.sourceNode == current) {
                                            showAlert = true
                                        } else {
                                            viewModel.algorithm.goalNode = current
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("O nó fonte não pode ser igual ao nó alvo"),
                message: Text("Escolha outro nó"),
                dismissButton: .default(Text("OK"))
            )
        }.padding()
    }
    
    func getEmptyColor(for current: String) -> Color {
        switch current {
        case viewModel.getGoalNode:
            return .red
        case viewModel.getSourceNode:
            return .accentColor
        default:
            return Color(.systemGray4)
        }
    }
    
    func getFilledColor(for current: String) -> Color {
        switch current {
        case viewModel.getGoalNode:
            return .red
        default:
            return .accentColor
        }
    }
    
    func getFilledSymbol(for current: String) -> String {
        switch current {
        case viewModel.getGoalNode:
            return "flag.square.fill"
        case viewModel.getSourceNode:
            return "location.square.fill"
        default:
            return "square.fill"
        }
    }
    
    func getEmptySymbol(for current: String) -> String {
        switch current {
        case viewModel.getGoalNode:
            return "flag.square.fill"
        case viewModel.getSourceNode:
            return "location.square.fill"
        default:
            return "square.fill"
        }
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

#Preview {
    GridView(viewModel: GridViewModel(algorithm: AlgorithmModel()), nodeSelection: NodeSelection())
}
