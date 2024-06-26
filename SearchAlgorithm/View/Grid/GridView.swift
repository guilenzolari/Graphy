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
                            
                            let color: Color = current == viewModel.getGoalNode ? .red : .blue
                            let symbol: String = current == viewModel.getGoalNode ? "flag.square.fill" : "square.fill"
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
