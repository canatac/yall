//
//  ObjectPool.swift
//  yall
//
//  Created by Can ATAC on 09/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation

class ObjectPoolForServiceAsker{

    private var data = [ServiceAsker]()
    
    init(){
        data.reserveCapacity(data.count)
        
    }
    
    private func doGetFromPool() -> ServiceAsker?{
        var result:ServiceAsker?
        if data.count > 0{
            result = self.data.removeAtIndex(0)
        }
        return result
    }
    private func doGetFromPool(id:String) -> ServiceAsker?{
        var result:ServiceAsker?
        
        if data.count > 0{
            var index = 0
            for obj in self.data{
                if obj.equals(id){
                    result = self.data.removeAtIndex(index)
                }
                index++
            } 
        }
       return result
    }
    
    private func doReturnToPool(item:ServiceAsker){
        self.data.append(item)
    }
    
    class func getFromPool() -> ServiceAsker?{
        return sharedInstance.doGetFromPool()
    }
    
    class func getFromPool(id:String) -> ServiceAsker?{
        return sharedInstance.doGetFromPool(id)
    }
    
    class func returnToPool(item:ServiceAsker){
        sharedInstance.doReturnToPool(item)
    }
    
    private class var sharedInstance:ObjectPoolForServiceAsker{
        get {
            struct SingletonWrapper {
                static let singleton = ObjectPoolForServiceAsker()
            }
            return SingletonWrapper.singleton
        }
    }
}

