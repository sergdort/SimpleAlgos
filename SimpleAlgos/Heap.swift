//
//  SwiftHeap.swift
//  SimpleAlgos
//
//  Created by Sergey Shulga on 3/18/15.
//  Copyright (c) 2015 Sergey Shulga. All rights reserved.
//

import Foundation

struct Heap<T:Comparable> {
    private var data:[T] = [T]()
    private let heapProperty:((lhs: T, rhs: T) -> Bool)
    var size:Int {
        get {
            return data.count
        }
    }
    
    init(heapProperty:(lhs: T, rhs: T) -> Bool) {
        self.heapProperty = heapProperty
    }
    
    mutating func insert(value:T) {
        data.append(value)
        bubleUp(data.count-1)
    }
    
    mutating func extract() -> T? {
        var element:T?
        
        if data.count > 0 {
            swap(&data[0], &data[data.count - 1])
            element = data.removeLast()
            bubleDown(0)
        }
        
        return element
    }
    
    //    MARK:Private
    
    mutating private func bubleUp(index:Int) {
        if self.heapProperty(lhs: data[index], rhs: data[parent(index)]) {
            swap(&data[index], &data[parent(index)])
            bubleUp(parent(index))
        }
    }
    
    mutating private func bubleDown(index:Int) {
        if index < data.count-1 {
            let children = childrenIndexes(index)
            let left:T? = children.left == nil ? nil : data[children.left!]
            let right:T? = children.right == nil  ? nil : data[children.right!]
            let minIdx:Int? = left<right ? children.left:children.right
            
            if let theMinIdx = minIdx {
                if !self.heapProperty(lhs: data[index], rhs: data[theMinIdx]) {
                    swap(&data[index], &data[theMinIdx])
                    bubleDown(theMinIdx)
                }
            }
        }
    }
    
    private func parent(index:Int) -> Int {
        return index/2
    }
    
    private func childrenIndexes(index:Int) -> (left:Int?, right:Int?) {
        return (2*index+1 >= data.count ? nil:2*index+1
            ,2*index+2 >= data.count ? nil:2*index+2)
    }
    
}

extension Heap:Printable {
    var description: String {
        get {
            return "Heap: \(data)"
        }
    }
}

extension Heap:DebugPrintable {
    var debugDescription:String {
        get {
            return self.description
        }
    }
}