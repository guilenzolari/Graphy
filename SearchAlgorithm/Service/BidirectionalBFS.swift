import Foundation

func bidirectionaBFS(
    graph: [String: [String]],
    source: String,
    goal: String
) -> DoublePathSolution {
    
    let queueStart = NSMutableOrderedSet(
        object: source
    )
    let queueEnd = NSMutableOrderedSet(
        object: goal
    )
    let visitedStart = NSMutableOrderedSet()
    let visitedEnd = NSMutableOrderedSet()
    
    var parentsStart: [String: String] = [:]
    var parentsEnd: [String: String] = [:]
    
    let finalStartPath = NSMutableOrderedSet()
    let finalEndPath = NSMutableOrderedSet()
    
    while queueStart.count > 0 && queueEnd.count > 0 {
        let currentStart = queueStart.firstObject as! String
        queueStart.removeObject(
            at: 0
        )
        let currentEnd = queueEnd.firstObject as! String
        queueEnd.removeObject(
            at: 0
        )
        
        if !visitedEnd.contains(
            currentEnd
        ) {
            visitedEnd.add(
                currentEnd
            )
        }
        
        if let valores = graph[currentEnd] {
            if (
                visitedStart.array as! [String]
            ).contains(where: {
                item in valores.contains(
                    item
                )
            }) {
                
                var pathNode = goal
                while let parent = parentsStart[pathNode] {
                    finalStartPath.insert(
                        pathNode,
                        at: 0
                    )
                    pathNode = parent
                }
                finalStartPath.insert(
                    source,
                    at: 0
                )
                
                var pathNodeEnd = source
                while let parentEnd = parentsEnd[pathNodeEnd] {
                    finalEndPath.insert(
                        pathNodeEnd,
                        at: 0
                    )
                    pathNodeEnd = parentEnd
                }
                finalEndPath.insert(
                    source,
                    at: 0
                )
                
                return DoublePathSolution(
                    hasPath: true,
                    startVisitedList: visitedStart.array as! [String],
                    endVisitedList: visitedEnd.array as! [String],
                    startFinalPath: (
                        finalStartPath.array as! [String]
                    ).reversed(),
                    endFinalPath: (
                        finalEndPath.array as! [String]
                    ).reversed()
                )
            }
        }
        
        
        if !visitedStart.contains(
            currentStart
        ) {
            visitedStart.add(
                currentStart
            )
        }
        
        if let valores = graph[currentStart] {
            if (
                visitedEnd.array as! [String]
            ).contains(where: {
                item in valores.contains(
                    item
                )
            }) {
                
                var pathNode = goal
                while let parent = parentsStart[pathNode] {
                    finalStartPath.insert(
                        pathNode,
                        at: 0
                    )
                    pathNode = parent
                }
                finalStartPath.insert(
                    source,
                    at: 0
                )
                
                var pathNodeEnd = source
                while let parentEnd = parentsEnd[pathNodeEnd] {
                    finalEndPath.insert(
                        pathNodeEnd,
                        at: 0
                    )
                    pathNodeEnd = parentEnd
                }
                finalEndPath.insert(
                    source,
                    at: 0
                )
                
                
                return DoublePathSolution(
                    hasPath: true,
                    startVisitedList: visitedStart.array as! [String],
                    endVisitedList: visitedEnd.array as! [String],
                    startFinalPath: (
                        visitedStart.array as! [String]
                    ).reversed(),
                    endFinalPath: (
                        visitedEnd.array as! [String]
                    ).reversed()
                )
            }
        }
        
        
        if let neighborsStart = graph[currentStart] {
            for neighbor in neighborsStart {
                if !visitedStart.contains(
                    neighbor
                ) {
                    queueStart.add(
                        neighbor
                    )
                    if parentsStart[neighbor] == nil {
                        parentsStart[neighbor] = currentStart
                    }
                }
            }
        }
        
        if let neighborsEnd = graph[currentEnd] {
            for neighbor in neighborsEnd {
                if !visitedEnd.contains(
                    neighbor
                ) {
                    queueEnd.add(
                        neighbor
                    )
                    if parentsEnd[neighbor] == nil {
                        parentsEnd[neighbor] = currentEnd
                    }
                }
            }
        }
    }
    
    var pathNode = goal
    while let parent = parentsStart[pathNode] {
        finalStartPath.insert(
            pathNode,
            at: 0
        )
        pathNode = parent
    }
    finalStartPath.insert(
        source,
        at: 0
    )
    
    var pathNodeEnd = source
    while let parentEnd = parentsEnd[pathNodeEnd] {
        finalEndPath.insert(
            pathNodeEnd,
            at: 0
        )
        pathNodeEnd = parentEnd
    }
    finalEndPath.insert(
        source,
        at: 0
    )
    
    return DoublePathSolution(
        hasPath: false, 
        startVisitedList: visitedStart.array as! [String],
        endVisitedList: visitedEnd.array as! [String],
        startFinalPath: (
            visitedStart.array as! [String]
        ).reversed(),
        endFinalPath: (
            visitedEnd.array as! [String]
        ).reversed()
    )
}

struct DoublePathSolution {
    
    var hasPath: Bool
    
    var startVisitedList: [String]
    var endVisitedList: [String]
    
    var startFinalPath: [String]
    var endFinalPath: [String]
    
    var startMaxSize: Int {
        startVisitedList.count
    }
    
    var endMaxSize: Int {
        endVisitedList.count
    }
    
    var startFinalPathSize: Int {
        startFinalPath.count
    }
    
    var endFinalPathSize: Int {
        endFinalPath.count
    }
    
    func startNodes(
        for timeStamp: Int
    ) -> [String] {
        guard timeStamp < startVisitedList.count else {
            return []
        }
        return [startVisitedList[timeStamp]]
    }
    
    func endNodes(
        for timeStamp: Int
    ) -> [String] {
        guard timeStamp < endVisitedList.count else {
            return []
        }
        return [endVisitedList[timeStamp]]
    }
    
    func finalStartNodes(
        for timeStamp: Int
    ) -> [String] {
        guard timeStamp < startFinalPath.count else {
            return []
        }
        return [startFinalPath[timeStamp]]
    }
    
    
    func finalEndNodes(
        for timeStamp: Int
    ) -> [String] {
        guard timeStamp < endFinalPath.count else {
            return []
        }
        return [endFinalPath[timeStamp]]
    }
}

