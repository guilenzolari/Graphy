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
                                .font(.system(size: 34))
                                .foregroundStyle(getColor(for: current))
                                .padding(.vertical, -6)
                                .padding(.horizontal, -4)
                    } else {
                            Image(systemName: getEmptySymbol(for: current))
                                .font(.system(size: 34))
                                .foregroundStyle(Color(.systemGray2))
                                .padding(.vertical, -6)
                                .padding(.horizontal, -4)
                        }
                    }
                }
            }
        }.padding()
    }
    
    func getColor(for current: String) -> Color {
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
}

#Preview {
    GridView(viewModel: GridViewModel(algorithm: AlgorithmModel()))
}
