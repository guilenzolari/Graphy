import SwiftUI

struct GridView: View {
    
    let viewModel: GridViewModel
    
    var body: some View {
        VStack {
            
            ForEach(1...viewModel.getRowSize, id: \.self) { i in
                HStack(spacing: 0) {
                    ForEach(1...viewModel.getColumnSize, id: \.self) { j in
                        let current = "\(i)-\(j)"
                        if viewModel.getPath.contains(current) {
                            Image(systemName: getFilledSymbol(for: current))
                                .font(.system(size: 26))
                                .foregroundStyle(getColor(for: current))
                                .padding(.all, 0)
                        } else {
                            Image(systemName: getEmptySymbol(for: current))
                                .font(.system(size: 26))
                                .foregroundStyle(Color(.systemGray2))
                                .padding(.all, 0)
                        }
                    }
                }
            }
        }
    }
    
    func getColor(for current: String) -> Color {
        switch current {
        case viewModel.getGoalNode:
            return .red
        default:
            return .blue
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
}

#Preview {
    GridView(viewModel: GridViewModel(algorithm: AlgorithmModel()))
}
