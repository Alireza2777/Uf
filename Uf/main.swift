//
//  main.swift
//  Uf
//
//  Created by Alireza Karimi on 2023-08-15.
//
// helped by chatgpt-stackoverflow
import Foundation

public struct UF {
    private var parent: [Int]
    private var size: [Int]
    private(set) var count: Int
    
    public init(_ n: Int) {
        self.count = n
        self.size = [Int](repeating: 1, count: n)
        self.parent = [Int](repeating: 0, count: n)
        for i in 0..<n {
            self.parent[i] = i
        }
    }
    
    public mutating func find(_ p: Int) -> Int {
        var root = p
        while root != parent[root] {
            root = parent[root]
        }
        
        // Path compression
        var current = p
        while current != root {
            let next = parent[current]
            parent[current] = root
            current = next
        }
        
        return root
    }
    
    public mutating func connected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    public mutating func union(_ p: Int, _ q: Int) {
        let rootP = find(p)
        let rootQ = find(q)
        
        if rootP == rootQ {
            return
        }
        
        // Weighted union: Attach smaller tree to larger tree
        if size[rootP] < size[rootQ] {
            parent[rootP] = rootQ
            size[rootQ] += size[rootP]
        } else {
            parent[rootQ] = rootP
            size[rootP] += size[rootQ]
        }
        
        count -= 1
    }
}


