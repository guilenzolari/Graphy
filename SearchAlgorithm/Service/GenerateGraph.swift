func generateGraph(
    columnSize: Int,
    rowSize: Int,
    barrier: [String]
) -> [String: [String]] {
    var graph = [String: [String]]()
    
    for row in 1...rowSize {
        for col in 1...columnSize {
            let node = "\(row)-\(col)"
            var neighbors = [String]()
            
            if (
                barrier.contains(
                    node
                )
            ) {
                
                
                
            } else {
                
                if row > 1 {
                    let n = "\(row-1)-\(col)"
                    if (
                        !barrier.contains(
                            n
                        )
                    ) {
                        neighbors.append(
                            n
                        )
                    }
                }
                if row < rowSize {
                    let n = "\(row+1)-\(col)"
                    if (
                        !barrier.contains(
                            n
                        )
                    ) {
                        neighbors.append(
                            n
                        )
                    }
                }
                if col > 1 {
                    let n = "\(row)-\(col-1)"
                    if (
                        !barrier.contains(
                            n
                        )
                    ) {
                        neighbors.append(
                            n
                        )
                    }
                }
                if col < columnSize {
                    let n = "\(row)-\(col+1)"
                    if (
                        !barrier.contains(
                            n
                        )
                    ) {
                        neighbors.append(
                            n
                        )
                    }
                }
                
                graph[node] = neighbors
            }
        }
    }
    
    return graph
}
