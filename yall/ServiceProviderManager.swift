//
//  ServiceProviderManager.swift
//  yall
//
//  Created by Can ATAC on 05/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import Parse

class ServiceProviderManager{
    private func goGetServiceProviderWithAddress(address:String)->ServiceProvider!{
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        
        let sa : ServiceProvider!
        let query = PFQuery(className:"ServiceProvider")
        var object: PFObject!
        
        do{
            try object = query.getFirstObject()
            sa = ServiceProvider.createServiceProvider(
                (object.objectId as? String!)!,
                newAddress:object["address"] as! String,
                newName:object["name"] as! String,
                newSurname:object["surname"] as! String,
                newPhone:(object["phone"] as? String)!,
                newEmail:(object["email"] as? String)!,
                newNotation:object["notation"] as! Int,
                newServices:object["services"] as! [String],
                newGeoPoint:object["geoPoint"] as! PFGeoPoint
            )
            //serviceProviderId:String,newAddress:String, newName:String, newSurname:String, newPhone:String,newEmail:String, newNotation:Int, newServices:[String], newGeoPoint:String
            return sa
            
        }
        catch{
            print("PB OCCURRED IN FETCH PARSE")
            
        }
        return nil

    }
    
    class func getServiceProviderWithAddress(address:String)->ServiceProvider!{
        return sharedInstance.goGetServiceProviderWithAddress(address)
    }
    
    
    
    /////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    
    private func goGetServiceProviderWithId(objectId:String)->ServiceProvider!{
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        print("goGetServiceProviderWithId")
        let sp : ServiceProvider!
        let query = PFQuery(className:"ServiceProvider")
        query.whereKey("objectId", equalTo: objectId)
        var object: PFObject!
        
        do{
            try object = query.getFirstObject()
            print("object retrieved by id : \(object)")
            sp = ServiceProvider.createServiceProvider(
                object.objectId!,
                newAddress:object["address"] as! String,
                newName:object["name"] as! String,
                newSurname:object["surname"] as! String,
                newPhone:(object["phone"] as? String)!,
                newEmail:(object["email"] as? String)!,
                newNotation:object["notation"] as! Int,
                newServices:object["services"] as! [String],
                newGeoPoint:object["geoPoint"] as! PFGeoPoint
            )
            //serviceProviderId:String,newAddress:String, newName:String, newSurname:String, newPhone:String,newEmail:String, newNotation:Int, newServices:[String], newGeoPoint:String
            return sp
            
        }
        catch{
            print("PB OCCURRED IN FETCH PARSE")
            
        }
        return nil
        
    }

    class func getServiceProviderWithId(objectId:String)->ServiceProvider!{
        return sharedInstance.goGetServiceProviderWithId(objectId)
    }

    /////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    
    private func goGetServiceProviderList(address:String)->[ServiceProvider]!{
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        
        var sp = [ServiceProvider]()
        print("someInts is of type [ServiceProvider] with \(sp.count) items.")
        let query = PFQuery(className:"ServiceProvider")
        var objects: [PFObject]!
        
        do{
            try objects = query.findObjects()
            
            for object in objects{
                sp.append(
                    ServiceProvider.createServiceProvider(
                        (object.objectId as? String!)!,
                        newAddress:object["address"] as! String,
                        newName:object["name"] as! String,
                        newSurname:object["surname"] as! String,
                        newPhone:object["phone"] as! String,
                        newEmail:object["email"] as! String,
                        newNotation:object["notation"] as! Int,
                        newServices:object["services"] as! [String],
                        newGeoPoint:object["geoPoint"] as! PFGeoPoint
                    )
                )
            }
            
            return sp
            
        }
        catch{
            print("PB OCCURRED IN FETCH PARSE")
            
        }
        return nil
        
    }

    class func getServiceProviderList(address:String)->[ServiceProvider]!{
        return sharedInstance.goGetServiceProviderList(address)
    }

    /////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    
    private func goGetServiceProviderListNearGeoPoint(geoPoint:PFGeoPoint)->[ServiceProvider]{
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        
        let query = PFQuery(className:"ServiceProvider");
        query.whereKey("geoPoint", nearGeoPoint: geoPoint, withinKilometers: 50.0)
        
        var objects:[PFObject]!
        var sps:[ServiceProvider] = [ServiceProvider]()
        do{
            try objects = query.findObjects()
            print("BEFORE LOOP OBJECTS RETRIEVED in getServiceProviderListNearGeoPoint : \(objects)")
            for object in objects{
                print("IN THE LOOP ON OBJECTS RETRIEVED in getServiceProviderListNearGeoPoint : \(object)")

                //let sp = ServiceProviderManager.getServiceProviderWithAddress(object["address"] as! String) as ServiceProvider!
                //let sp = ServiceProviderManager.getServiceProviderWithId(object.objectId!) as ServiceProvider!
                let sp = ServiceProvider.createServiceProvider(
                    object.objectId!,
                    newAddress:object["address"] as! String,
                    newName:object["name"] as! String,
                    newSurname:object["surname"] as! String,
                    newPhone:(object["phone"] as? String)!,
                    newEmail:(object["email"] as? String)!,
                    newNotation:object["notation"] as! Int,
                    newServices:object["services"] as! [String],
                    newGeoPoint:object["geoPoint"] as! PFGeoPoint
                )
                print("SP created in getServiceProviderListNearGeoPoint : \(sp.name)")

                sps.append(sp)
                print("SP added in [SP] in getServiceProviderListNearGeoPoint : \(sps)")

            }
        }catch{
            print("ERROR IN FETCHING OBJECTS NEAR ME")
        }
        print("OBJECTS returned in getServiceProviderListNearGeoPoint : \(sps)")

        return sps
    }
    
    class func getServiceProviderListNearGeoPoint(geoPoint:PFGeoPoint)->[ServiceProvider]{
        return sharedInstance.goGetServiceProviderListNearGeoPoint(geoPoint)
    }
    
    /////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    
    private func goUpdate(sp:ServiceProvider){
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        let query = PFQuery(className:"ServiceProvider")
        query.whereKey("address", equalTo: "\(sp.address)")
        var object: PFObject!
        
        do{
            try object = query.getFirstObject()
            object["address"]     = sp.address
            object["name"]        = sp.name
            object["surname"]     = sp.surname
            object["phone"]       = sp.phone
            object["email"]       = sp.email
            object["notation"]    = sp.notation
            object["geoPoint"]    = sp.geoPoint
            object["services"]    = sp.services

            
        }
        catch{
            print("PB OCCURRED IN CREATING PARSE")
            
        }
        
        do{
            try object.save()
        }
        catch{
            print("PB IN SAVING UPDATED OBJECT")
        }
        
    }

    class func update(sp:ServiceProvider){
        sharedInstance.goUpdate(sp)
    }
    
    /////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////
    
    @objc func save(notification:NSNotification){
        print("save \(notification.object?.description)")
        var string:String = (notification.object?.description)!
        print("Formatting not object to string: \(string)")
        save(ObjectPoolForServiceProvider.getFromPool(string)!)
        print("save HERE")
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "net.canatac.hommeatoutfaire.serviceprovider.geopoint.ok", object: nil)
        
    }
    
    private func save(sp:ServiceProvider){
        // Initialize Parse.
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        let spObject = PFObject(className: "ServiceProvider")
        spObject["address"] =   sp.address
        spObject["name"]    =   sp.name
        spObject["surname"] =   sp.surname
        spObject["phone"]       = sp.phone
        spObject["email"]       = sp.email
        spObject["notation"]    = sp.notation
        spObject["geoPoint"]    = sp.geoPoint
        spObject["services"]    = sp.services
        
        /*
        do{
            try spObject.save()
            print("SP Object has been saved.")
        }catch{
            print("PB OCCURED WHEN SAVING SA")
        }
        */
        spObject.saveInBackgroundWithBlock{(success: Bool, error:NSError?)-> Void in                NSNotificationCenter.defaultCenter().postNotificationName("net.canatac.hommeatoutfaire.serviceactormg.save.ok", object: nil)
        }
    }
    
    class func save(sp:ServiceProvider){
        sharedInstance.save(sp)
    }
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////
    
    
    class var sharedInstance:ServiceProviderManager{
        get {
            struct SingletonWrapper {
                static let singleton = ServiceProviderManager()
            }
            return SingletonWrapper.singleton
        }
    }
    
}