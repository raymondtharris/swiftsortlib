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
    override var description:String{
        return "\(self.index)"
    }
    init(index:Int){
        self.index = index
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
println(manager)
