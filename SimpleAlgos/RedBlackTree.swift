//
//  RedBlackTree.swift
//  SimpleAlgos
//
//  Created by Sergey Shulga on 3/18/15.
//  Copyright (c) 2015 Sergey Shulga. All rights reserved.
//

import Foundation

enum NodeColor:Int {
    case Red
    case Black
}

struct RedBlackTree {
    

    
    class Node {
        var item:Int
        var left:Node?
        var right:Node?
        var parent:Node?
        var color = NodeColor.Red
        
        init(item:Int) {
            self.item = item
        }
        
        func brother() -> Node? {
            var father = self.parent
            return father?.left === self ? father?.right : father?.left
        }
        func greand() -> Node? {
            return self.parent?.parent
        }
    }
    
    private var root:Node?
    
    init() {
        
    }
    
    mutating func insert(item:Int) {
        if self.root == nil {
            self.root = Node(item: item)
            self.root?.color = .Black
        } else {
            insert(item, node: root!);
            root!.color = .Black
        }
    }
    
    private mutating func insert(item:Int, node:Node) {
        if item > node.item {
            if let right = node.right {
                insert(item, node: right)
            } else {
                var newNode = Node(item: item)
                node.right = newNode
                newNode.parent = node
                color(newNode)
            }
        } else {
            if let left = node.left {
                insert(item, node: left)
            } else {
                var newNode = Node(item: item)
                node.left = newNode
                newNode.parent = node
                color(newNode)
            }
        }
    }
    
    private mutating func color(var x:Node) {
        while x !== root && x.parent!.color == .Red {
            println("X = \(x)")
            if x.parent === x.greand()?.left {
                var y = x.greand()?.right
                if y == nil || y!.color == .Black {
                    if x === x.parent?.right {
                        x = x.parent!
                        rotateLeft(x)
                    }
                    
                    x.parent?.color = .Black
                    x.greand()?.color = .Red
                    rotateRight(x.greand()!)
                } else {
                    x.parent?.color = .Black
                    y?.color = .Black
                    x.greand()?.color = .Red
                    x = x.greand()!
                }
            } else {
                var y = x.greand()?.left
                if y == nil || y!.color == .Black {
                    if x === x.parent?.left {
                        x = x.parent!
                        rotateRight(x)
                    }
                    x.parent?.color = .Black
                    x.greand()?.color = .Red
                    rotateLeft(x.parent!)
                } else {
                    x.parent?.color = .Black
                    y?.color = .Black
                    x.greand()?.color = .Red
                    x = x.greand()!
                }
            }
        }
    }
    
    private mutating func rotateRight(x:Node) {
        var y = x.right
        y?.left = y?.right
        y?.right?.parent = x
        
        y?.parent = x.parent
        
        if x.parent != nil {
            if x === x.parent?.right {
                x.parent?.right = y
            } else {
                x.parent?.left = y
            }
        } else {
            root = y!
        }
        y?.right = x
        x.parent = y
    }
    private mutating func rotateLeft(var y:Node) {
//        var y = x.right
//        
//        x.right = y?.left
//        y?.parent = x.parent
//        if x.parent != nil {
//            if x === x.parent?.left {
//                x.parent?.left = y
//            } else {
//                x.parent?.right = y
//            }
//        } else {
//            root = y!
//        }
//        
//        y?.left = x
//        x.parent = y
        var x = y.parent
        var p = x?.parent
        var b = x?.right
        
        if x === p?.left {
            p?.left = y
        } else {
            p?.right = y
        }
        y.parent = p
        
        y.left = x
        x?.parent = y
        
        x?.right = b
        b?.parent = x
        if x === root {
            root = y
        }
    }
}

