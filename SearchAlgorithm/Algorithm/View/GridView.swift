import SwiftUI

struct GridView: View {
    
    let viewModel: AlgorithmViewModel
    
    var body: some View {
        VStack {
            
            ForEach(1...viewModel.algorithmRowSize, id: \.self) { i in
                HStack(spacing: 0) {
                    ForEach(1...viewModel.algorithmColumnSize, id: \.self) { j in
                        let current = "\(i)-\(j)"
                        if viewModel.algorithmPath.contains(current) {
                            
                            let color: Color = current == viewModel.algorithmGoalNode ? .red : .blue
                            let symbol: String = current == viewModel.algorithmGoalNode ? "flag.square.fill" : "square.fill"
                            Image(systemName: symbol)
                                .imageScale(.large)
                                .foregroundStyle(color)
                        } else {
                            Image(systemName: "square")
                                .imageScale(.large)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
        }
    }
}
