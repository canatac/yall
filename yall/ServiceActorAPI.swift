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
    public class func updateServiceActor(actorId:String,serviceActor:String,formData:[String:String],services:[String], geoPoint:[String:Double]){
        
        deleteServiceActor(actorId, serviceActor: NSUserDefaults.standardUserDefaults().stringForKey("serviceActorType")!)
        createServiceActor(serviceActor, formData: formData, services: services, geoPoint: geoPoint)
    }
    public class func deleteServiceActor(actorId:String, serviceActor:String){
        if serviceActor == "PROVIDER"{
            ServiceProviderFactory.deleteServiceProvider(actorId)
        }
        else if serviceActor == "ASKER"{
            ServiceAskerFactory.deleteServiceAsker(actorId)
        }
    }
    public class func createServiceActor(serviceActor:String,formData:[String:String],services:[String], geoPoint:[String:Double]){
        if serviceActor == "PROVIDER"{
            ServiceProviderFactory.createServiceProvider(
                formData["Address"]!,
                newName:formData["Name"]!,
                newSurname:formData["Surname"]!,
                newEmail:formData["Email"]!,
                newPhone:formData["Phone"]!,
                newNotation:0,
                newServices:services,
                newGeoPoint:geoPoint)
        }
        else if serviceActor == "ASKER"{
            ServiceAskerFactory.createServiceAsker(
                formData["Address"]!,
                newName:formData["Name"]!,
                newSurname:formData["Surname"]!,
                newEmail:formData["Email"]!,
                newPhone:formData["Phone"]!,
                newServices:services,
                newGeoPoint:geoPoint)
        }
    }
    
    public class func getServiceActorWithUDID() -> AnyObject? {
        let x:AnyObject? = ServiceProviderFactory.getWithUDID(),y:AnyObject? = ServiceAskerFactory.getWithUDID()
        
        if x != nil {
            NSUserDefaults.standardUserDefaults().setObject("PROVIDER", forKey: "serviceActorType")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).serviceProviderId,forKey:"serviceActorId")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).name,forKey:"serviceActorName")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).surname,forKey:"serviceActorSurname")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).address,forKey:"serviceActorAddress")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).phone,forKey:"serviceActorMobileNumber")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).email,forKey:"serviceActorEmail")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).services as [String],forKey:"serviceActorServices")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).geoPoint.latitude, forKey: "serviceActorGeoPointLatitude")
            NSUserDefaults.standardUserDefaults().setObject((x as! ServiceProvider!).geoPoint.longitude, forKey: "serviceActorGeoPointLongitude")
        }else
        if y != nil {
            NSUserDefaults.standardUserDefaults().setObject("ASKER", forKey: "serviceActorType")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).serviceAskerId,forKey:"serviceActorId")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).name,forKey:"serviceActorName")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).surname,forKey:"serviceActorSurname")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).address,forKey:"serviceActorAddress")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).phone,forKey:"serviceActorMobileNumber")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).email,forKey:"serviceActorEmail")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).services as [String],forKey:"serviceActorServices")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).geoPoint.latitude, forKey: "serviceActorGeoPointLatitude")
            NSUserDefaults.standardUserDefaults().setObject((y as! ServiceAsker!).geoPoint.longitude, forKey: "serviceActorGeoPointLongitude")
        }
        return x != nil ? x:y
    }
}