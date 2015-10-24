
//
//  ObjectPoolForServiceProvider.swift
//  yall
//
//  Created by Can ATAC on 12/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation

class ObjectPoolForServiceProvider{
    private var data = [ServiceProvider]()
    
    init(){
        data.reserveCapacity(data.count)
        
    }
    
    private func doGetFromPool() -> ServiceProvider?{
        var result:ServiceProvider?
        if data.count > 0{
            result = self.data.removeAtIndex(0)
        }
        return result
    }
    private func doGetFromPool(id:String) -> ServiceProvider?{
        var result:ServiceProvider?
        
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
    
    private func doReturnToPool(item:ServiceProvider){
        self.data.append(item)
    }
    
    class func getFromPool() -> ServiceProvider?{
        return sharedInstance.doGetFromPool()
    }
    
    class func getFromPool(id:String) -> ServiceProvider?{
        return sharedInstance.doGetFromPool(id)
    }
    
    class func returnToPool(item:ServiceProvider){
        sharedInstance.doReturnToPool(item)
    }
    
    private class var sharedInstance:ObjectPoolForServiceProvider{
        get {
            struct SingletonWrapper {
                static let singleton = ObjectPoolForServiceProvider()
            }
            return SingletonWrapper.singleton
        }
    }

}