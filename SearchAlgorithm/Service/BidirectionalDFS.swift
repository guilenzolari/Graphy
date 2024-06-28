func bidirectionaDFS(graph: [String: [String]], source: String, goal: String) -> DoublePathSolution {
    
    var queueStart = [source]
    var queueEnd = [goal]
    var visitedStart = [String]()
    var visitedEnd = [String]()

    while !queueStart.isEmpty && !queueEnd.isEmpty {
        
        let currentStart = queueStart.removeLast()
        let currentEnd = queueEnd.removeLast()
        
        //start
        if !visitedStart.contains(currentStart) {
            visitedStart.append(currentStart)
        }
        
        if !visitedEnd.contains(currentEnd) {
            visitedEnd.append(currentEnd)
        }

        if visitedStart.contains(currentEnd) {
            return DoublePathSolution(startVisitedList: visitedStart, endVisitedList: visitedEnd)
        }
        
        if visitedEnd.contains(currentStart) {
            return DoublePathSolution(startVisitedList: visitedStart, endVisitedList: visitedEnd)
        }

        if let neighborsStart = graph[currentStart] {
            for neighbor in neighborsStart {
                if !visitedStart.contains(neighbor) {
                    queueStart.append(neighbor)
                }
            }
        }
        
        if let neighborsEnd = graph[currentEnd] {
            for neighbor in neighborsEnd {
                if !visitedEnd.contains(neighbor) {
                    queueEnd.append(neighbor)
                }
            }
        }
    }
    
    return DoublePathSolution(startVisitedList: visitedStart, endVisitedList: visitedEnd)
}

