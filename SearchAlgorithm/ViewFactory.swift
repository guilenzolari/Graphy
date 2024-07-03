import Foundation

// Router or Coordinator or Configurator
struct ViewFactory {
    
    let dependencies: Dependencies
    
    func gridView() -> GridView {
        let algorithm = dependencies.algorithm
        let nodeSelection = dependencies.nodeSelection
        let viewModel = GridViewModel(algorithm: algorithm)
        return GridView(viewModel: viewModel, nodeSelection: dependencies.nodeSelection)
    }
    
    func homeView() -> HomeView {
        let algorithm = dependencies.algorithm
        let nodeSelection = dependencies.nodeSelection
        let viewModel = HomeViewModel(algorithm: algorithm, nodeSelection: nodeSelection)
        return HomeView(viewModel: viewModel)
    }
    
    func selectionView(callback: @escaping (AlgorithmType) -> Void) -> SelectionView {
        let algorithm = dependencies.algorithm
        let viewModel = SelectionViewModel(algorithm: algorithm)
        return SelectionView(viewModel: viewModel, callback: callback)
    }
}
