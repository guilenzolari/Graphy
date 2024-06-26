import SwiftUI

struct AlgorithmView: View {
    @State private var colorfulls: [String] = []
    @State private var currentColorIndex = 0
    @State private var timer: Timer?
    @State private var columnSize: Int = 12
    @State private var rowSize: Int = 12
    @State private var selectedAlgorithm: Algorithm = .none
    @State private var goalNode: String = "4-4"
    @State private var sourceNode: String = "1-1"

    var body: some View {
        VStack {
            
            Picker("Selecione o algoritmo desejado", selection: $selectedAlgorithm) {
                ForEach(Algorithm.allCases) { algorithm in
                    Text(algorithm.rawValue).tag(algorithm)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedAlgorithm) { newAlgorithm in
                startSimulation()
            }
            
            VStack(spacing: 0) {
                ForEach(1...rowSize, id: \.self) { i in
                    HStack(spacing: 0) {
                        ForEach(1...columnSize, id: \.self) { j in
                            let current = "\(i)-\(j)"
                            if colorfulls.contains(current) {
                                
                                let color: Color = current == goalNode ? .red : .blue
                                let symbol: String = current == goalNode ? "flag.square.fill" : "square.fill"
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
                Button(action: {
                    clearSimulation()
                }, label: {
                    Text("Clear")
                })
                .padding()
            }
        }
        .navigationTitle("Algoritmos")
        .padding()
    }

    func startSimulation() {
        clearSimulation()
        let path = getAlgorithm()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if currentColorIndex < path.count {
                colorfulls.append(path[currentColorIndex])
                currentColorIndex += 1
            } else {
                timer?.invalidate()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
    
    func clearSimulation() {
        stopTimer()
        colorfulls = []
        currentColorIndex = 0
    }
    
    func getAlgorithm() -> [String] {
        let graph = generateGraph(columnSize: columnSize, rowSize: rowSize)
        switch(selectedAlgorithm) {
        case .bfs: return breadthFirst(graph: graph, source: sourceNode, goal: goalNode)
        case .dfs: return depthFirst(graph: graph, source: sourceNode, goal: goalNode)
        case .aStar:
            return []
        case .dkjstra:
            return []
        case .none: return []
        }
    }
}

#Preview {
    AlgorithmView()
}

enum Algorithm: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case dfs = "DFS"
    case bfs = "BFS"
    case aStar = "A*"
    case dkjstra = "Djkstra"
    case none = "Nenhum"
}
