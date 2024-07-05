import Foundation

func bidirectionaBFS(graph: [String: [String]], source: String, goal: String) -> DoublePathSolution {
    
    let queueStart = NSMutableOrderedSet(object: source)
    let queueEnd = NSMutableOrderedSet(object: goal)
    let visitedStart = NSMutableOrderedSet()
    let visitedEnd = NSMutableOrderedSet()

    while queueStart.count > 0 && queueEnd.count > 0 {
        let currentStart = queueStart.firstObject as! String
        queueStart.removeObject(at: 0)
        let currentEnd = queueEnd.firstObject as! String
        queueEnd.removeObject(at: 0)
        
        if !visitedStart.contains(currentStart) {
            visitedStart.add(
                currentStart
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
                return DoublePathSolution(
                    startVisitedList: visitedStart.array as! [String],
                    endVisitedList: visitedEnd.array as! [String]
                )
            }
        }
        
        if !visitedEnd.contains(currentEnd) {
            visitedEnd.add(currentEnd)
        }
        
        if let valores = graph[currentStart] {
            if (visitedEnd.array as! [String]).contains(where: { item in valores.contains(item) }) {
                return DoublePathSolution(startVisitedList: visitedStart.array as! [String], endVisitedList: visitedEnd.array as! [String])
            }
        }

        if let neighborsStart = graph[currentStart] {
            for neighbor in neighborsStart {
                if !visitedStart.contains(neighbor) {
                    queueStart.add(neighbor)
                }
            }
        }
        
        if let neighborsEnd = graph[currentEnd] {
            for neighbor in neighborsEnd {
                if !visitedEnd.contains(neighbor) {
                    queueEnd.add(neighbor)
                }
            }
        }
    }
    
    return DoublePathSolution(startVisitedList: visitedStart.array as! [String], endVisitedList: visitedEnd.array as! [String])
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

