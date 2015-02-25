//
//  main.swift
//  DataTesting
//
//  Created by Tim Harris on 1/9/15.
//  Copyright (c) 2015 Tim Harris. All rights reserved.
//

import Foundation

class node: NSObject, NSCopying{
    var index:Int
    var payload: dataObject
    var next: node? = nil
    override var description:String{
        return "\(self.index)"
    }
    required init(index:Int){
        self.index = index
        self.payload = dataObject()
    }
    func copyWithZone(zone: NSZone) -> AnyObject {
        var objCopy = self.dynamicType(index: self.index)
        return objCopy
    }
}

class dataObject: NSObject {
    
}


class trNode: NSObject {
    var index:Int
    var left:trNode? = nil
    var right:trNode? = nil
    var neighbors = 0
    var cost:Int = 1
    override var description:String{
        return "\(self.index)"
    }
    init(index:Int) {
        self.index = index
    }
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
        if let hasroot = root{
            
        }else{
            root = newNode
        }
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
    override var description:String{
        var curr = self.head
        var pstr = ""
        while curr != nil{
            pstr += "\( curr!.index)-> "
            curr = curr?.next
        }
        return pstr
    }
    func insertAtEnd(newNode:node){
        
        if let hasHead = self.head{
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

class queue: NSObject {
    var head:node? = nil
    var tail:node? = nil
    var length:Int = 0
    var isEmpty:Bool{
        if self.length > 0 {
            return true
        } else{
            return false
        }
    }
    override var description:String{
        var curr = self.head
        var pstr = ""
        while curr != nil{
            pstr += "\( curr!.index)-> "
            curr = curr?.next
        }
        return pstr
    }
    override init() {
        
    }
    func enqueue(nodeToInsert:node){
        if let hasHead = self.head{
            self.tail?.next = nodeToInsert
            self.tail = nodeToInsert
        }else{
            //println("empty")
            self.head = nodeToInsert
            self.tail = self.head
        }
        self.length++
        //println(self.length)
    }
    func dequeue()->node?{
        if let hasHead = self.head{
            self.head = self.head?.next
            self.length--
            //println(self.length)
            return hasHead
        }else{
            self.head = nil
            self.tail = nil
            return nil
        }
    }
}


class graph: NSObject {
    var isEmpty = true
    var adjList:[(neighborlist: linkedList, nodeIndex: Int)] = []
    var path: [node] = [node]()
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
            self.adjList.insert((newNeighborList, newNode.index), atIndex: self.adjList.count)
            self.isEmpty = false
        }else{
            var newNeighborList = linkedList()
            newNeighborList.insertAtEnd(newNode)
            self.adjList.insert((newNeighborList, newNode.index), atIndex: self.adjList.count)
        }
        self.numberOfVertecies++
    }
    func remove(nodeToRemove:node){
        for obj in self.adjList{
            if obj.nodeIndex ==  nodeToRemove.index{
                var current = obj.neighborlist.head?.next
                while current != nil{
                    for obj2 in self.adjList{
                        if obj2.nodeIndex == current?.index{
                            obj2.neighborlist.remove(nodeToRemove)
                        }
                    }
                    current = current?.next
                }
            }
        }
        self.numberOfVertecies--
    }
    
    func insertNeighbor(fromNode:node, toNode:node){
        var toNodeCopy = toNode.copy() as node
        
        for obj in adjList{
            if obj.nodeIndex == fromNode.index{
                obj.neighborlist.insertAtEnd(toNodeCopy)
            }
        }
        self.numberOfEdges++
    }
    
    
    func removeNeighbor(fromNode:node, betweenNode:node){
        for obj in adjList{
            if obj.nodeIndex == fromNode.index{
                obj.neighborlist.remove(betweenNode)
            }
        }
    }
    func search(nodeToFind:node)->node?{
        for obj in adjList{
            if obj.nodeIndex == nodeToFind.index{
                return obj.neighborlist.head
            }
        }
        return nil
    }
    
    func BFS(fromStart:node, toGoal:node)->node?{
        var tempPath = queue()
        var tempArr = [Int]()
        var current = search(fromStart)
        
        tempArr.append(current!.index)
        var tempN = current?.copy() as node
        
        tempPath.enqueue(tempN)
        
        while tempPath.length > 0 {
            var tempNode = tempPath.dequeue()
            if tempNode?.index == toGoal.index{
                //self.path.append(tempNode!)
                return tempNode!
            }else{
                current = search(tempNode!)
                while current?.next != nil{
                    //println(" \(current!) -> \(current!.next!) ")
                    current = current?.next
                   
                    var check = false
                    for objs in tempArr{
                        if objs == current?.index{
                            check = true
                        }
                    }
        
                    if check != true {
                        tempArr.append(current!.index)
                        tempNode = search(current!)
                        tempPath.enqueue(tempNode!.copy() as node)
                    }
                }
            }
            
        }
        return nil
    }
    func shortestPath(fromStart:node, toGoal:node){
        var unvisited:[(nodeIndex:Int, distance:Int)] = []
        var visited:[(nodeIndex:Int, distance:Int)] = []
        for obj in adjList {
            if obj.nodeIndex == fromStart.index{
                unvisited.insert((obj.nodeIndex, 0), atIndex: unvisited.count)
            }else{
                unvisited.insert((obj.nodeIndex, 1000), atIndex: unvisited.count)
            }
            
        }
        //println(unvisited)
        
        var tempQueue = queue()
        var current = search(fromStart)
        var index:Int = 0
        var goalFound = false
        
        while !goalFound{
            var currentCheck = current
            var headNode:(nodeIndex:Int, distance:Int)
            var chek:Int = 0
            for var i = 0 ;i < unvisited.count; i++  {
                if unvisited[i].nodeIndex == currentCheck?.index {
                    chek = i
                }
            }
            headNode = (unvisited[chek].nodeIndex, unvisited[chek].distance)
            while currentCheck != nil{
                for var i = 0 ;i < unvisited.count; i++ {
                    if unvisited[i].nodeIndex == currentCheck?.index  && unvisited[i].distance > headNode.distance {
                        //if let newVal = headNode {
                        unvisited[i].distance = headNode.distance + 1
                        //}
                    }
                }
                currentCheck = currentCheck?.next
                if let newt = currentCheck{
                    tempQueue.enqueue(currentCheck!)
                }
            }
            
            
            var i=0
            for obj in unvisited{
                if obj.nodeIndex == current?.index{
                    if obj.distance >= index {
                        //index++
                    }
                    visited.append(obj)
                    unvisited.removeAtIndex(i)
                }
                i++
            }
            //println(unvisited)
            //println(visited)
            //index++
            //println(tempQueue)
            current = search(tempQueue.dequeue()!)
            
            
            if current?.index == toGoal.index {
                goalFound = true
                var c=0
                for obj in unvisited{
                    if obj.nodeIndex == current?.index{
                        visited.append(obj)
                        unvisited.removeAtIndex(c)
                    }
                    c++
                }
            }

        }
        println(visited)
        
        
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

var g1 = graph()

var n1 = node(index: 5)
var n2 = node(index: 8)
var n3 = node(index: 10)
var n4 = node(index: 2)
var n5 = node(index: 4)

g1.insert(n1)
g1.insert(n2)
g1.insert(n3)
g1.insert(n4)
g1.insert(n5)
g1.insertNeighbor(n1, toNode: n3)
g1.insertNeighbor(n3, toNode: n2)
g1.insertNeighbor(n2, toNode: n4)
g1.insertNeighbor(n1, toNode: n5)
g1.insertNeighbor(n5, toNode: n4)
println(g1.adjList)

//g1.BFS(n1, toGoal: n4)

g1.shortestPath(n1, toGoal: n4)


