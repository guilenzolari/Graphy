import Foundation

func breadthFirst(graph: [String: [String]], source: String, goal: String) -> SolutionPath {
    let queue = NSMutableOrderedSet(object: source)
    let visited = NSMutableOrderedSet()
    var parents: [String: String] = [:]
    let finalPath = NSMutableOrderedSet()

    while queue.count > 0 {
        let current = queue.firstObject as! String
        queue.removeObject(at: 0)
        
        if !visited.contains(current) {
            visited.add(current)
        }
        
        if(current == goal) {
            var pathNode = goal
            while let parent = parents[pathNode] {
                finalPath.insert(pathNode, at: 0)
                pathNode = parent
            }
            finalPath.insert(source, at: 0)
            return SinglePathSolution(visitedList: visited.array as! [String], finalPath: finalPath.array as! [String])
        }
        
        if let neighbors = graph[current] {
            for neighbor in neighbors {
                if !visited.contains(neighbor) {
                    queue.add(neighbor)
                    if parents[neighbor] == nil { 
                        parents[neighbor] = current
                    }
                }
            }
        }
    }
    
    var pathNode = goal
    while let parent = parents[pathNode] {
        finalPath.insert(pathNode, at: 0)
        pathNode = parent
    }
    finalPath.insert(source, at: 0)
    return SinglePathSolution(visitedList: visited.array as! [String], finalPath: finalPath.array as! [String])
}


protocol SolutionPath {
    func nodes(for timeStamp: Int) -> [String]
    func finalNodes(for timeStamp: Int) -> [String]
    var visitedMaxSize: Int { get }
    var finalPathMaxSize: Int { get }
}

struct SinglePathSolution: SolutionPath {
    
    var visitedList: [String]
    var finalPath: [String]
    
    var visitedMaxSize: Int {
        visitedList.count
    }
    
    var finalPathMaxSize: Int {
        finalPath.count
    }
    
    func nodes(for timeStamp: Int) -> [String] {
        guard timeStamp < visitedList.count else { return [] }
        return [visitedList[timeStamp]]
    }
    
    func finalNodes(for timeStamp: Int) -> [String] {
        guard timeStamp < finalPath.count else { return [] }
        return [finalPath[timeStamp]]
    }
}

