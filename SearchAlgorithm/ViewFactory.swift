import Foundation

// Router or Coordinator or Configurator
struct ViewFactory {
    
    let dependencies: Dependencies
    
    func gridView() -> GridView {
        let algorithm = dependencies.algorithm
        let viewModel = GridViewModel(algorithm: algorithm)
        return GridView(viewModel: viewModel)
    }
    
    func homeView() -> HomeView {
        let algorithm = dependencies.algorithm
        let viewModel = HomeViewModel(algorithm: algorithm)
        return HomeView(viewModel: viewModel)
    }
    
    func selectionView() -> SelectionView {
        let algorithm = dependencies.algorithm
        let viewModel = SelectionViewModel(algorithm: algorithm)
        return SelectionView(viewModel: viewModel)
    }
}
