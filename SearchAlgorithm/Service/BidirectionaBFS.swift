func bidirectionaBFS(graph: [String: [String]], source: String, goal: String) -> DoublePathSolution {
    
    var queueStart = [source]
    var queueEnd = [goal]
    var visitedStart = [String]()
    var visitedEnd = [String]()

    while !queueStart.isEmpty && !queueEnd.isEmpty {
        
        let currentStart = queueStart.removeFirst()
        let currentEnd = queueEnd.removeFirst()
        
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

struct DoublePathSolution {
    
    var startVisitedList: [String]
    var endVisitedList: [String]
    
    var startMaxSize: Int {
        startVisitedList.count
    }
    
    var endMaxSize: Int {
        endVisitedList.count
    }
    
    func startNodes(for timeStamp: Int) -> [String] {
        guard timeStamp < startVisitedList.count else { return [] }
        return [startVisitedList[timeStamp]]
    }
    
    func endNodes(for timeStamp: Int) -> [String] {
        guard timeStamp < endVisitedList.count else { return [] }
        return [endVisitedList[timeStamp]]
    }
}

