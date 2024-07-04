import SwiftUI

struct CustomToolBar: View {
    
    @State private var showSpeedToolbar = false
    @State private var showGridToolbar = false
    
    let isActionButtonDisabled: Bool
    let startSimulation: () -> Void
    let clearSimulation: () -> Void
    let clearGrid: () -> Void
    let algorithm: AlgorithmModel
    let nodeSelection: NodeSelection
    
    var body: some View {
        @Bindable var algorithmBinding = algorithm
        if showSpeedToolbar {
            
            HStack {
                HStack {
                    Image(
                        systemName: "tortoise"
                    )
                    .font(
                        .system(
                            size: 20
                        )
                    )
                    .fontWeight(
                        .regular
                    )
                    .foregroundColor(
                        .gray
                    )
                    Slider(
                        value: $algorithmBinding.speed,
                        in: 0.01...0.2
                    ).padding(
                        .horizontal,
                        6
                    )
                    .padding(
                        .vertical,
                        4
                    )
                    
                    Image(
                        systemName: "hare"
                    )
                    .font(
                        .system(
                            size: 20
                        )
                    )
                    .fontWeight(
                        .regular
                    )
                    .foregroundColor(
                        .gray
                    )
                }
                .padding(
                    .horizontal,
                    12
                )
                .background(
                    Color.gray.opacity(
                        0.1
                    )
                )
                .cornerRadius(
                    20
                )
                
                Spacer()
                Text(
                    "OK"
                )
                .font(
                    .body
                )
                .foregroundColor(
                    .accentColor
                )
                .padding(
                    .trailing
                )
                .fontWeight(
                    .semibold
                )
                .onTapGesture {
                    withAnimation {
                        showSpeedToolbar = false
                    }
                }
            }.padding()
                .padding(
                    .bottom,
                    16
                )
                .transition(
                    .move(
                        edge: .bottom
                    ).combined(
                        with: .opacity
                    )
                )
                .ignoresSafeArea()
                .background(
                    .background.secondary
                )
        }
        
        if showGridToolbar {
            
            HStack {
                Spacer()
                Button(action: {
                    nodeSelection.nodeType = .sourceNode
                }) {
                    HStack {
                        Image(
                            systemName: "location.square.fill"
                        )
                        .font(
                            .system(
                                size: 26
                            )
                        )
                        .fontWeight(
                            .thin
                        )
                        .foregroundColor(
                            .blue
                        )
                    }
                    .background(
                        RoundedRectangle(
                            cornerRadius: 4
                        )
                        .stroke(
                            Color.blue,
                            lineWidth: (
                                nodeSelection.nodeType == .sourceNode
                            ) ? 2 : 0
                        )
                    )
                }
                Button(action: {
                    nodeSelection.nodeType = .goalNode
                }) {
                    HStack {
                        Image(
                            systemName: "flag.square.fill"
                        )
                        .font(
                            .system(
                                size: 26
                            )
                        )
                        .fontWeight(
                            .thin
                        )
                        .foregroundColor(
                            .red
                        )
                    }
                    .background(
                        RoundedRectangle(
                            cornerRadius: 4
                        )
                        .stroke(
                            Color.blue,
                            lineWidth: (
                                nodeSelection.nodeType == .goalNode
                            ) ? 2 : 0
                        )
                    )
                }
                Button(action: {
                    nodeSelection.nodeType = .barrier
                }) {
                    HStack {
                        Image(
                            systemName: "minus.square.fill"
                        )
                        .font(
                            .system(
                                size: 26
                            )
                        )
                        .fontWeight(
                            .thin
                        )
                        .foregroundColor(
                            .primary
                        )
                    }
                    .background(
                        RoundedRectangle(
                            cornerRadius: 4
                        )
                        .stroke(
                            Color.blue,
                            lineWidth: (
                                nodeSelection.nodeType == .barrier
                            ) ? 2 : 0
                        )
                    )
                }
                Spacer()
                Text(
                    "OK"
                )
                .font(
                    .body
                )
                .foregroundColor(
                    .accentColor
                )
                .fontWeight(
                    .semibold
                )
                .onTapGesture {
                    withAnimation {
                        showGridToolbar = false
                        nodeSelection.nodeType = .none
                    }
                }
            }.padding()
                .transition(
                    .move(
                        edge: .bottom
                    ).combined(
                        with: .opacity
                    )
                )
                .ignoresSafeArea()
                .background(
                    .background.secondary
                )
        }
        
        if !showSpeedToolbar && !showGridToolbar {
            HStack {
                Button(action: {
                    startSimulation()
                }) {
                    Image(
                        systemName: "memories"
                    )
                    .font(
                        .title2
                    )
                    .fontWeight(
                        .regular
                    )
                }.disabled(
                    isActionButtonDisabled
                )
                Spacer()
                Button(action: {
                    withAnimation {
                    clearSimulation()
                    showGridToolbar.toggle()
                        nodeSelection.nodeType = .sourceNode
                }
                }) {
                    Image(
                        systemName: "square.and.pencil"
                    )
                    .font(
                        .title2
                    )
                    .fontWeight(
                        .regular
                    )
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        showSpeedToolbar.toggle()
                    }
                }) {
                    Image(
                        systemName: "speedometer"
                    )
                    .font(
                        .title2
                    )
                    .fontWeight(
                        .regular
                    )
                }.disabled(
                    isActionButtonDisabled
                )
                Spacer()
                Button(action: {
                    clearGrid()
                }) {
                    Image(
                        systemName: "eraser"
                    )
                    .font(
                        .title2
                    )
                    .fontWeight(
                        .regular
                    )
                }.disabled(
                    isActionButtonDisabled
                )
            }
            .padding()
            .ignoresSafeArea()
            .background(
                .background.secondary
            )
            .offset(
                y: (
                    showSpeedToolbar || showGridToolbar
                ) ? UIScreen.main.bounds.height : 0
            )
            .animation(
                .easeInOut(
                    duration: 0.5
                ),
                value: (
                    showSpeedToolbar || showGridToolbar
                )
            )
        }
    }
}

#Preview {
    CustomToolBar(isActionButtonDisabled: false,
                  startSimulation: {},
                  clearSimulation: {},
                  clearGrid: {},
                  algorithm: AlgorithmModel(),
                  nodeSelection: NodeSelection())
}

enum NodeType {
    case sourceNode
    case goalNode
    case barrier
    case none
}
