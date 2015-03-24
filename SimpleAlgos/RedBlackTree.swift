//
//  RedBlackTree.swift
//  SimpleAlgos
//
//  Created by Sergey Shulga on 3/18/15.
//  Copyright (c) 2015 Sergey Shulga. All rights reserved.
//

import Foundation

class Node<T:Comparable> {
    var item:T
    var left:Node?
    var right:Node?
    var parent:Node?
    var color = NodeColor.Red
    
    init(item:T) {
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

enum NodeColor {
    case Red
    case Black
}

struct RedBlackTree <T:Comparable> {
    
    private var root:Node<T>?
    
    init() {
        
    }
    
    mutating func insert(item:T) {
        if self.root == nil {
            self.root = Node(item: item)
            self.root?.color = .Black
        } else {
            insert(item, node: root!);
            root!.color = .Black
        }
    }
    
    private mutating func insert(item:T, node:Node<T>) {
        if item > node.item {
            if let right = node.right {
                insert(item, node: right)
            } else {
                var newNode = Node(item: item)
                node.right = newNode
                newNode.parent = node
                color_case1(newNode)
            }
        } else {
            if let left = node.left {
                insert(item, node: left)
            } else {
                var newNode = Node(item: item)
                node.left = newNode
                newNode.parent = node
                color_case1(newNode)
            }
        }
    }
    
    //    MARK:Private
    
    private mutating func color_case1(node:Node<T>) {
        node.color = .Red
        if let parent = node.parent {
            if parent.color == .Black {
                if parent === self.root {
                    color_case2(node)
                } else {
                    return
                }
            } else {
                color_case2(node)
            }
        }
    }
    
    private mutating func color_case2(node:Node<T>) {
        if node.parent?.brother() == nil || node.parent!.brother()!.color == .Black {
            color_case2a(node)
        } else {
            color_case2b(node)
        }
    }
    
    private mutating func color_case2a(node:Node<T>) {
        if node === node.parent?.left && node.parent === node.greand()?.left {
            node.greand()?.greand()?.color = .Red
            node.parent?.color = .Black
            if node.greand() != nil {
                rotateRight(node.greand()!)
            }
        } else if node === node.parent?.right && node.parent === node.greand()?.left {
            node.color = .Black
            node.greand()?.color = .Red
            rotateLeft(node.parent!)
            rotateRight(node.parent!)
        } else if node === node.parent?.right && node.parent === node.greand()?.right {
            node.greand()?.color = .Red
            node.parent?.color = .Black
            rotateLeft(node.greand()!)
        } else if node === node.parent?.left && node.parent === node.greand()?.right {
            node.greand()?.color = .Red
            node.color = .Black
            
            rotateRight(node.parent!)
            rotateLeft(node.parent!)
        }
    }
    
    private mutating func color_case2b(node:Node<T>) {
        var greand = node.greand()
        var uncle = node.parent?.brother()
        greand?.color = .Red
        node.parent?.color = .Black
        uncle?.color = .Black
        
        if greand != nil {
            color_case1(greand!)
        }
    }
    
    private mutating func rotateRight(y:Node<T>) {
        var x = y.left
        var p = y.parent
        var b = x?.right
        
        if y === self.root {
            self.root = x
        }
        if y === p?.right {
            p?.right = x
        } else {
            p?.left = x
        }
        x?.parent = p
        
        x?.right = y
        y.parent = x
        
        y.left = b
        b?.parent = y
    }
    
    private mutating func rotateLeft(var x:Node<T>) {
        var y = x.right
        var p = x.parent
        var b = y?.left
        
        if x === self.root {
            self.root = y
        }
        if x === p?.right {
            p?.right = y
        } else {
            p?.left = y
        }
        y?.parent = p
        
        y?.left = x
        x.parent = y
        
        x.right = b
        b?.parent = x
    }
}

