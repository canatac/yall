//
//  ServiceProviderAPI.swift
//  yall
//
//  Created by Can ATAC on 08/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import MapKit
import Parse

class ServiceProviderFactory{
    
    class func getListWithMyLocation(location:CLLocation)->Dictionary<String,Dictionary<String, AnyObject>>{
        let geopoint:PFGeoPoint =   PFGeoPoint(location: location)
        var myDic               =   Dictionary<String,Dictionary<String, AnyObject>>()
        
        let providers:[ServiceProvider] = ServiceProviderManager.getServiceProviderListNearGeoPoint(geopoint)
        for provider in providers{
            print("PROVIDER in API : \(provider.name) - \(provider.surname) - \(provider.address)")
            var tmp:Dictionary<String,AnyObject>=Dictionary<String,AnyObject>()
            tmp["name"]         =   provider.name
            tmp["surname"]      =   provider.surname
            tmp["address"]      =   provider.address
            tmp["phone"]        =   provider.phone
            tmp["email"]        =   provider.email
            tmp["notation"]     =   provider.notation
            tmp["services"]     =   provider.services
            tmp["latitude"]     =   provider.geoPoint.latitude
            tmp["longitude"]    =   provider.geoPoint.longitude

            myDic[provider.serviceProviderId] = tmp
        }
        return myDic
        
    }
    
    class func getWithUDID()->AnyObject?{
        return ServiceProviderManager.getWithUDID()
    }
    
    class func createServiceProvider(
        newAddress:     String,
        newName:        String,
        newSurname:     String,
        newEmail:       String,
        newPhone:       String,
        newNotation:    Int,
        newServices:    [String],
        newGeoPoint:    [String:Double]
        )
    {
        _ = ServiceProvider.createServiceProvider(
            newAddress,
            newName:    newName,
            newSurname: newSurname,
            newEmail:   newEmail,
            newPhone:   newPhone,
            newNotation:newNotation,
            newServices:newServices,
            newGeoPoint:PFGeoPoint(latitude: newGeoPoint["latitude"]!, longitude: newGeoPoint["longitude"]!)
        )
        
    }
    
    class func deleteServiceProvider(actorId:String){
        _ = ServiceProvider.deleteServiceProvider(
            actorId
        )
    }
}