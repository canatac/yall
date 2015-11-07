//
//  ServiceActorAPI.swift
//  yall
//
//  Created by Can ATAC on 25/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import MapKit

public class ServiceActorAPI{

    
    public class func getListWithMyLocation(serviceActor:String,location:CLLocation)->Dictionary<String,Dictionary<String, AnyObject>>{
        if serviceActor == "PROVIDER"{
            return ServiceProviderFactory.getListWithMyLocation(location)
        }
        else if serviceActor    ==  "ASKER"{
            return ServiceAskerFactory.getListWithMyLocation(location)
        }
        return Dictionary<String,Dictionary<String, AnyObject>>()
    }
    
    public class func createServiceActor(serviceActor:String,formData:[String:String]){
        if serviceActor == "PROVIDER"{
            ServiceProviderFactory.createServiceProvider(
                formData["address"]!,
                newName:formData["name"]!,
                newSurname:formData["surname"]!,
                newEmail:formData["email"]!,
                newPhone:formData["phone"]!)
        }
        else if serviceActor == "ASKER"{
            ServiceAskerFactory.createServiceAsker(
                formData["address"]!,
                newName:formData["name"]!,
                newSurname:formData["surname"]!,
                newEmail:formData["email"]!,
                newPhone:formData["phone"]!)
        }
    }

}