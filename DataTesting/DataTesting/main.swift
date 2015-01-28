//
//  main.swift
//  DataTesting
//
//  Created by Tim Harris on 1/9/15.
//  Copyright (c) 2015 Tim Harris. All rights reserved.
//

import Foundation

class node: NSObject{
    var index:Int
    var payload: dataObject
    var next: node? = nil
    override var description:String{
        return "\(self.index)"
    }
    init(index:Int){
        self.index = index
        self.payload = dataObject()
    }
}

class dataObject: NSObject {
    
}


class tree: NSObject {
    var root: node? = nil
    var height: Int
    var isEmpty: Bool
    override init() {
        isEmpty = true
        height = 0
    }
    
    func insert(newNode:node){
        
    }
    func search()->node?{
        return nil
    }
}

class linkedList: NSObject {
    var head: node? = nil
    var tail: node? = nil
    var length: Int
    override init(){
        self.length = 1
    }
    func insertAtEnd(newNode:node){
        if let hasHad = self.head{
            self.tail?.next = newNode
            self.tail = newNode
        }else{
            self.head = newNode
            self.tail = self.head
        }
        self.length++
    }
    func search(nodeToSearchFor:node)->node?{
        var current = self.head
        while(current != nil){
            if current == nodeToSearchFor{
                return current
            }else{
                current = current?.next
            }
        }
        
        return nil
    }
    func searchByIndex(nodeToSearchForIndex:Int)->node?{
        var current = self.head
        while(current != nil){
            if current?.index == nodeToSearchForIndex{
                return current
            }else{
                current = current?.next
            }
        }
        return nil
    }
    
    func remove(nodeToRemove:node)->Bool{
        var current = self.head
        if current == nodeToRemove{
            current?.next = self.head
            self.length--
            return true
        }
        while current != nil {
            if current?.next  == nodeToRemove{
                var temp = current?.next
                current?.next = temp?.next
                temp?.next = nil
                self.length--
                return true
            }else{
                current = current?.next
            }
        }
        return false
    }
}


class graph: NSObject {
    var isEmpty = true
    var adjList:[(neighborlist: linkedList, nodeIndex: Int)] = []
    var numberOfEdges: Int
    var numberOfVertecies: Int
    var directed: Bool
    override init() {
        self.numberOfEdges = 0
        self.numberOfVertecies = 0
        self.directed = true
    }
    init(directed:Bool) {
        self.numberOfEdges = 0
        self.numberOfVertecies = 0
        self.directed = directed
    }
    func insert(newNode:node){
        if self.isEmpty{
            var newNeighborList = linkedList()
            newNeighborList.insertAtEnd(newNode)
            self.adjList.insert((newNeighborList, newNode.index), atIndex: self.adjList.count-1)
            self.isEmpty = false
        }
    }
    func insertNeighbor(fromNode:node, toNode:node){
        for obj in adjList{
            if obj.nodeIndex == fromNode.index{
                obj.neighborlist.insertAtEnd(toNode)
            }
        }
    }
    
    
    
}

class Sorter{
    var dataInUse:[node]
    init(data:[node]){
        self.dataInUse = data
        quickSort(1, last: dataInUse.count)
        
    }
    func quickSort(first:Int, last:Int){
        var mid:Int
        if first < last{
            mid = partition(first, last: last)
            quickSort(first, last: mid-1)
            quickSort(mid+1, last: last)
            
        }
    }
    func partition(first:Int, last:Int)->Int{
        var temp = dataInUse[last-1]
        var i = first-1
        for var j = first; j < last; j++ {
            if dataInUse[j - 1].index <= temp.index{
                i = i+1
                var tempData = dataInUse[i - 1]
                dataInUse[i - 1] = dataInUse[j - 1]
                dataInUse[j - 1] = tempData
            }
        }
        var tempData2 = dataInUse[i]
        dataInUse[i] = dataInUse[last-1]
        dataInUse[last-1] = tempData2
        return i+1
    }
    
    
}




class DataManagerObject: NSObject{
    var isEmpy:Bool = true
    var data:[node] = []
    var dataManagerSorter:Sorter
    override var description:String{
        return "\(self.data)"
    }
    init(newData:[Int]){
        for i in newData{
            self.data.append(node(index: i))
        }
        self.dataManagerSorter = Sorter(data: self.data)
        self.data = self.dataManagerSorter.dataInUse
        self.isEmpy = false
    }
}

var smallDataSet = [4,3,5,7,9,23,456,234,32,74,45,134,743,7956,3456,4211,323,412,55454,37,654,342,36,12412]

var manager = DataManagerObject(newData: smallDataSet)
