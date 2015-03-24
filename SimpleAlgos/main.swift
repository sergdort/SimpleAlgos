//
//  main.swift
//  SimpleAlgos
//
//  Created by Sergey Shulga on 3/18/15.
//  Copyright (c) 2015 Sergey Shulga. All rights reserved.
//

import Foundation

var heap = Heap<Int>(heapProperty: < )


var tree = RedBlackTree<Int>()

for var i = 1; i <= 15; i++ {
    tree.insert(i)
}

println("Inorder")
tree.inorder_traversal { (item) -> () in
    println(item)
}

println("PreOrder")
tree.preorder_traversal { (item) -> () in
    println(item)
}

println("PostOrder")
tree.postorder_traversal { (item) -> () in
    println(item)
}

println("BFSOrder")
tree.bfs_traversal { (item) -> () in
    println(item)
}

println("DFSOrder")
tree.dfs_traversal { (item) -> () in
    println(item)
}
heap.insert(-5)