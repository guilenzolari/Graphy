import SwiftUI

struct HomeView: View {
    let viewFactory = ViewFactory(dependencies: Dependencies.shared)
    
    var viewModel: HomeViewModel
    
    @State private var isActionButtonDisabled = true
    
    var body: some View {
        GeometryReader { totalSize in
            VStack {
                List {
                    Section {
                        viewFactory.selectionView { type in
                            viewModel.startSimulation(for: type)
                        }
                    }
                }.frame(minHeight: 64, maxHeight: 64).padding(.all, 0)
                
                VStack {
                    viewFactory.gridView()
                    Spacer()
                }
                Spacer()
                
                CustomToolBar(isActionButtonDisabled: isActionButtonDisabled,
                              startSimulation: { viewModel.startSimulation(for: viewModel.getType)
                },
                              clearSimulation: { viewModel.clearSimulation()
                },
                              algorithm: viewModel.algorithm,
                              nodeSelection: viewModel.nodeSelection)
            }
        }.background(.background.secondary)
            .navigationTitle("Grafo")
            .navigationBarItems(
                leading: AboutButton(),
                trailing: QuestionButton()
            )
            
            .onChange(of: viewModel.getType, perform: { _ in
                isActionButtonDisabled = viewModel.getType == .none
            })
        }
}

#Preview {
    HomeView(viewModel: HomeViewModel(algorithm: AlgorithmModel(), nodeSelection: NodeSelection()))
}

