func generateGraph(columnSize: Int, rowSize: Int) -> [String: [String]] {
    var graph = [String: [String]]()

    for row in 1...rowSize {
        for col in 1...columnSize {
            let node = "\(row)-\(col)"
            var neighbors = [String]()

            if row > 1 {
                neighbors.append("\(row-1)-\(col)")
            }
            if row < rowSize {
                neighbors.append("\(row+1)-\(col)")
            }
            if col > 1 {
                neighbors.append("\(row)-\(col-1)")
            }
            if col < columnSize {
                neighbors.append("\(row)-\(col+1)")
            }

            graph[node] = neighbors
        }
    }

    return graph
}
