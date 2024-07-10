import Foundation

func bidirectionaDFS(graph: [String: [String]], source: String, goal: String) -> DoublePathSolution {
    
    var queueStart = [source]
    var queueEnd = [goal]
    let visitedStart = NSMutableOrderedSet()
    let visitedEnd = NSMutableOrderedSet()

    while !queueStart.isEmpty && !queueEnd.isEmpty {
        
        let currentStart = queueStart.removeLast()
        let currentEnd = queueEnd.removeLast()
        
        if !visitedEnd.contains(currentEnd) {
            visitedEnd.add(currentEnd)
        }
        
        if let valores = graph[currentEnd] {
            if (visitedStart.array as! [String]).contains(where: { item in valores.contains(item) }) {
                return DoublePathSolution(
                    hasPath: true, 
                    startVisitedList: visitedStart.array as! [String],
                    endVisitedList: visitedEnd.array as! [String],
                    startFinalPath: (visitedStart.array as! [String]).reversed(),
                    endFinalPath: (visitedEnd.array as! [String]).reversed()
                )
            }
        }
        
        
        if !visitedStart.contains(currentStart) {
            visitedStart.add(currentStart)
        }
        
        if let valores = graph[currentStart] {
            if (visitedEnd.array as! [String]).contains(where: { item in valores.contains(item) }) {
                return DoublePathSolution(
                    hasPath: true,
                    startVisitedList: visitedStart.array as! [String],
                    endVisitedList: visitedEnd.array as! [String],
                    startFinalPath: (visitedStart.array as! [String]).reversed(),
                    endFinalPath: (visitedEnd.array as! [String]).reversed()
                )
            }
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
    
    return DoublePathSolution(
        hasPath: false,
        startVisitedList: visitedStart.array as! [String],
        endVisitedList: visitedEnd.array as! [String],
        startFinalPath: (visitedStart.array as! [String]).reversed(),
        endFinalPath: (visitedEnd.array as! [String]).reversed()
    )
}
