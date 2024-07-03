import SwiftUI

struct GridView: View {
    
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
                                        viewModel.algorithm.sourceNode = current
                                    } else if(nodeSelection.nodeType == .goalNode) {
                                        viewModel.algorithm.goalNode = current
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
                                    vibrate()
                                    if(nodeSelection.nodeType == .sourceNode) {
                                        viewModel.algorithm.sourceNode = current
                                    } else if(nodeSelection.nodeType == .goalNode) {
                                        viewModel.algorithm.goalNode = current
                                    }
                                    
                                }
                        }
                    }
                }
            }
        }.padding()
    }
    
    func getEmptyColor(for current: String) -> Color {
        switch current {
        case viewModel.getGoalNode:
            return .red
        case viewModel.getSourceNode:
            return .accentColor
        default:
            return Color(.systemGray2)
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
            return "flag.square"
        case viewModel.getSourceNode:
            return "location.square"
        default:
            return "square"
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
