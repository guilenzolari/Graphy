import SwiftUI
import UniformTypeIdentifiers

struct GridView: View {
    
    @State private var showAlert = false
    @State private var pulsingCell: String?
    @State private var draggedItem: String?
    
    let viewModel: GridViewModel
    let nodeSelection: NodeSelection
    
    var body: some View {
        VStack {
            ForEach(1...viewModel.getRowSize, id: \.self) { i in
                HStack(spacing: 0) {
                    ForEach(1...viewModel.getColumnSize, id: \.self) { j in
                        let current = "\(i)-\(j)"
                        let isBarrier = viewModel.algorithm.barrier.contains(current)
                        let isFinalNode = viewModel.algorithm.finalPath.contains(current)
                        CellView(
                            current: current,
                            isPulsing: pulsingCell == current,
                            isDragging: draggedItem == current,
                            isFilled: viewModel.getPath.contains(current),
                            onTap: { handleTap(on: current) },
                            onDrag: { handleDrag(for: current) },
                            onDrop: { providers in handleDrop(providers: providers, on: current) },
                            goalNode: viewModel.getGoalNode, 
                            sourceNode: viewModel.getSourceNode,
                            isBarrier: isBarrier,
                            isFinalNode: isFinalNode
                        )
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("O nó fonte não pode ser igual ao nó alvo"),
                message: Text("Escolha outro nó"),
                dismissButton: .default(Text("OK"))
            )
        }
        .padding()
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func pulse(cell: String) {
        pulsingCell = cell
        withAnimation(Animation.easeInOut(duration: 0.2).repeatCount(1, autoreverses: true)) {
            pulsingCell = nil
        }
    }
    
    func handleTap(on current: String) {
        if isSourceNodeSelected() {
            if isGoalNode(current) {
                showAlert = true
            } else {
                viewModel.algorithm.sourceNode = current
                vibrate()
                pulse(cell: current)
            }
        } else if isGoalNodeSelected() {
            if isSourceNode(current) {
                showAlert = true
            } else {
                vibrate()
                pulse(cell: current)
                viewModel.algorithm.goalNode = current
            }
        } else if isBarrierSelected() {
            vibrate()
            pulse(cell: current)
            viewModel.algorithm.barrier.append(current)
        }
    }
    
    func handleDrag(for current: String) -> NSItemProvider {
        if(isSourceNode(current) || isGoalNode(current)) {
            self.draggedItem = current
            return NSItemProvider(object: current as NSString)
        } else {
            return NSItemProvider()
        }
    }
    
    func handleDrop(providers: [NSItemProvider], on target: String) -> Bool {
        guard let provider = providers.first, provider.canLoadObject(ofClass: NSString.self) else {
            return false
        }
        
        provider.loadObject(ofClass: NSString.self) { (item, error) in
            if let draggedItem = item as? String {
                if self.isGoalNode(draggedItem) {
                    if self.isSourceNode(target) {
                        self.showAlert = true
                    } else {
                        self.viewModel.algorithm.goalNode = target
                        self.vibrate()
                        self.pulse(cell: target)
                    }
                } else if self.isSourceNode(draggedItem) {
                    if self.isGoalNode(target) {
                        self.showAlert = true
                    } else {
                        self.viewModel.algorithm.sourceNode = target
                        self.vibrate()
                        self.pulse(cell: target)
                    }
                }
                self.draggedItem = nil
            }
        }
        
        return true
    }
    
    func isSourceNodeSelected() -> Bool {
        return nodeSelection.nodeType == .sourceNode
    }
    
    func isGoalNodeSelected() -> Bool {
        return nodeSelection.nodeType == .goalNode
    }
    
    func isBarrierSelected() -> Bool {
        return nodeSelection.nodeType == .barrier
    }
    
    func isSourceNode(_ current: String) -> Bool {
        return viewModel.getSourceNode == current
    }
    
    func isGoalNode(_ current: String) -> Bool {
        return viewModel.getGoalNode == current
    }
}

struct CellView: View {
    let current: String
    let isPulsing: Bool
    let isDragging: Bool
    let isFilled: Bool
    let onTap: () -> Void
    let onDrag: () -> NSItemProvider
    let onDrop: ([NSItemProvider]) -> Bool
    let goalNode: String
    let sourceNode: String
    let isBarrier: Bool
    let isFinalNode: Bool
    
    var body: some View {
        Image(systemName: getSymbol())
            .font(.system(size: isPulsing ? 38 : 34))
            .foregroundStyle(getColor())
            .padding(.vertical, -6)
            .padding(.horizontal, -4)
            .scaleEffect(isPulsing ? 1.2 : 1.0)
            .opacity(isDragging ? 0.5 : 1.0)
            .animation(.easeInOut(duration: 0.2).repeatCount(1, autoreverses: true), value: isPulsing)
            .onTapGesture(perform: onTap)
            .onDrag(onDrag)
            .onDrop(of: [UTType.text], isTargeted: nil, perform: onDrop)
    }
    
    func getColor() -> Color {
        switch current {
        case goalNode:
            return .red
        case sourceNode:
            return .accentColor
        default:
            if (isBarrier) {
                return .primary
            }
            if (isFinalNode) {
                return .green
            }
            return isFilled ? .accentColor : Color(.systemGray4)
        }
    }
    
    func getSymbol() -> String {
        switch current {
        case goalNode:
            return "flag.square.fill"
        case sourceNode:
            return "location.square.fill"
        default:
            if (isBarrier) {
                return "minus.square.fill"
            }
            if (isFinalNode) {
                return "circle.square.fill"
            }
            return "square.fill"
        }
    }
}

#Preview {
    GridView(viewModel: GridViewModel(algorithm: AlgorithmModel()), nodeSelection: NodeSelection())
}

