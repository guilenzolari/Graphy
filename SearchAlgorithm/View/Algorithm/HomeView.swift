import SwiftUI

struct HomeView: View {
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    
    var viewModel: HomeViewModel
    
    @State private var isActionButtonDisabled = true
    @State private var showSppedToolbar = false
    @State private var showGridToolbar = false
    
    var body: some View {
        @Bindable var algorithmBinding = viewModel.algorithm
        
        GeometryReader { totalSize in
            VStack {
                List {
                    Section {
                        viewFactory.selectionView { type in
                            viewModel.startSimulation(for: type)
                        }
                    }
                }.frame(maxHeight: 64).padding(.all, 0)
                
                VStack {
                    viewFactory.gridView()
                    Spacer()
                }.toolbar {
                    if !showSppedToolbar && !showGridToolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                viewModel.startSimulation(for: viewModel.getType)
                            }) {
                                Image(systemName: "memories")
                                    .frame(width: 26, height: 22)
                            }.disabled(isActionButtonDisabled)
                            Spacer()
                            Button(action: {
                                showGridToolbar.toggle()
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .frame(width: 26, height: 22)
                            }.disabled(isActionButtonDisabled)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    showSppedToolbar.toggle()
                                }
                            }) {
                                Image(systemName: "speedometer")
                                    .frame(width: 26, height: 22)
                            }.disabled(isActionButtonDisabled)
                            Spacer()
                            Button(action: {
                                viewModel.clearSimulation()
                            }) {
                                Image(systemName: "eraser")
                                    .frame(width: 26, height: 22)
                            }.disabled(isActionButtonDisabled)
                        }
                    }
                }
            }
            .navigationTitle("Grafo")
            .navigationBarItems(
                leading: AboutButton(),
                trailing: QuestionButton()
            )
            .toolbar {
                
                if showSppedToolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Slider(value: $algorithmBinding.speed, in: 0.01...0.2)
                                .padding()
                            Spacer()
                            Text("OK")
                                .font(.body)
                                .foregroundColor(.accentColor)
                                .fontWeight(.semibold)
                                .onTapGesture {
                                    withAnimation {
                                        showSppedToolbar = false
                                    }
                                }
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                if showGridToolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                viewModel.clearSimulation()
                            }) {
                                Image(systemName: "location.square.fill")
                                    .frame(width: 26, height: 22).foregroundStyle(.blue)
                            }
                            Spacer()
                            Button(action: {
                                viewModel.clearSimulation()
                            }) {
                                Image(systemName: "flag.square.fill")
                                    .frame(width: 26, height: 22).foregroundStyle(Color(.red))
                            }
                            Spacer()
                            Button(action: {
                                viewModel.clearSimulation()
                            }) {
                                Image(systemName: "square")
                                    .frame(width: 26, height: 22).foregroundStyle(Color(.gray))
                            }
                            Spacer()
                            Text("OK")
                                .font(.body)
                                .foregroundColor(.accentColor)
                                .fontWeight(.semibold)
                                .onTapGesture {
                                    withAnimation {
                                        showGridToolbar = false
                                    }
                                }
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            .onChange(of: viewModel.getType, perform: { _ in
                isActionButtonDisabled = viewModel.getType == .none
            })
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(algorithm: AlgorithmModel()))
}

