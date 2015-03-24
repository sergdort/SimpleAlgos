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


heap.insert(-5)