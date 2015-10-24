//
//  ServiceAskerAPI.swift
//  yall
//
//  Created by Can ATAC on 08/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import MapKit
import Parse

class ServiceAskerFactory{
    
    class func getListWithMyLocation(location:CLLocation)->Dictionary<String,Dictionary<String, AnyObject>>{
        let geopoint:PFGeoPoint =   PFGeoPoint(location: location)
        var myDic               =   Dictionary<String,Dictionary<String, AnyObject>>()
        
        let askers:[ServiceAsker] = ServiceAskerManager.getServiceAskerListNearGeoPoint(geopoint)
        for asker in askers{
            var tmp:Dictionary<String,AnyObject>=Dictionary<String,AnyObject>()
            tmp["name"]         =   asker.name
            tmp["surname"]      =   asker.surname
            tmp["address"]      =   asker.address
            tmp["phone"]        =   asker.phone
            tmp["email"]        =   asker.email
            tmp["notation"]     =   asker.notation
            tmp["services"]     =   ServicesManager.getListNames(asker.services)
            tmp["latitude"]     =   asker.geoPoint.latitude
            tmp["longitude"]    =   asker.geoPoint.longitude
            
            myDic[asker.serviceAskerId] = tmp
        }
        return myDic
    }
    
    class func createServiceAsker(newAddress:String,
        newName: String,
        newSurname:String,
        newEmail:String,
        newPhone:String){
           
            ServiceAskerManager.createServiceAsker(
                newAddress,
                newName: newName,
                newSurname: newSurname,
                newEmail: newEmail,
                newPhone: newPhone
            )
    }
}