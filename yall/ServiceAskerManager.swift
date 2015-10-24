//
//  ServiceAskerManager.swift
//  yall
//
//  Created by Can ATAC on 05/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import Parse

final class ServiceAskerManager{
    
    /////////////////////////////////////////////////////////
    
    private func goCreateServiceAsker(newAddress:String,
        newName: String,
        newSurname: String,
        newEmail: String,
        newPhone: String){
            
            
            
            ServiceAsker.createServiceAsker(
                newAddress,
                newName: newName,
                newSurname: newSurname,
                newEmail: newEmail,
                newPhone: newPhone
            )
    
    }
    
    class func createServiceAsker(newAddress:String,
        newName: String,
        newSurname: String,
        newEmail: String,
        newPhone: String){
            sharedInstance.goCreateServiceAsker(newAddress, newName: newName, newSurname: newSurname, newEmail: newEmail, newPhone: newPhone)
    }
    
    /////////////////////////////////////////////////////////
    
    private func goGetServiceAskerWithAddress(address:String)->ServiceAsker!{
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        let sa : ServiceAsker!
        let query = PFQuery(className:"ServiceAsker")
        query.whereKey("address", equalTo: address)
        var object: PFObject!

        do{
            try object =  query.getFirstObject()
            
            print("\(object)")
            sa = ServiceAsker.createServiceAsker(
                (object.objectId as? String!)!,
                newAddress:object["address"] as! String,
                newName:object["name"] as! String,
                newSurname:object["surname"] as! String,
                newPhone:(object["phone"] as? String)!,
                newEmail:(object["email"] as? String)!,
                newNotation:object["notation"] as! Int,
                newDisabledSPs:object["disabledSPs"] as! [String],
                newGeoPoint:object["geoPoint"] as! PFGeoPoint,
                newServices:object["services"] as! [String]
                )
            return sa
            //serviceAskerId:String,newAddress:String, newName:String, newSurname:String, newPhone:String,newEmail:String, newNotation:Int, newDisabledSPs:[String], newGeoPoint:String,services:[String]
        }
        catch{
            print("PB OCCURRED IN FETCH PARSE")
            
        }
        return nil
    
    }
    
    class func getServiceAskerWithAddress(address:String)->ServiceAsker!{
        return sharedInstance.goGetServiceAskerWithAddress(address)
    }
    
    /////////////////////////////////////////////////////////
    
    private func goGetServiceAskerWithId(objectId:String)->ServiceAsker!{
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        
        let sa : ServiceAsker!
        let query = PFQuery(className:"ServiceAsker")
        query.whereKey("objectId", equalTo: objectId)
        var object: PFObject!
        
        do{
            try object =  query.getFirstObject()
            
            print("\(object)")
            sa = ServiceAsker.createServiceAsker(
                object.objectId!,
                newAddress:object["address"] as! String,
                newName:object["name"] as! String,
                newSurname:object["surname"] as! String,
                newPhone:(object["phone"] as? String)!,
                newEmail:(object["email"] as? String)!,
                newNotation:object["notation"] as! Int,
                newDisabledSPs:object["disabledSPs"] as! [String],
                newGeoPoint:object["geoPoint"] as! PFGeoPoint,
                newServices:object["services"] as! [String]
            )
            return sa
            //serviceAskerId:String,newAddress:String, newName:String, newSurname:String, newPhone:String,newEmail:String, newNotation:Int, newDisabledSPs:[String], newGeoPoint:String,services:[String]
        }
        catch{
            print("PB OCCURRED IN FETCH PARSE")
            
        }
        return nil
        
    }
    
    class func getServiceAskerWithId(objectId:String)->ServiceAsker!{
        return sharedInstance.goGetServiceAskerWithId(objectId)
    }

    /////////////////////////////////////////////////////////

    private func goGetServiceAskerList()->[ServiceAsker]!{
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        var sa = [ServiceAsker]()
        let query = PFQuery(className:"ServiceAsker")
        var objects: [PFObject]!
        
        do{
            try objects = query.findObjects()

            for object in objects{
                sa.append(
                    ServiceAsker.createServiceAsker(
                        (object.objectId as? String!)!,
                        newAddress:object["address"] as! String,
                        newName:object["name"] as! String,
                        newSurname:object["surname"] as! String,
                        newPhone:object["phone"] as! String,
                        newEmail:object["email"] as! String,
                        newNotation:object["notation"] as! Int,
                        newDisabledSPs:object["disabledSPs"] as! [String],
                        newGeoPoint:object["geoPoint"] as! PFGeoPoint,
                        newServices:object["services"] as! [String]
                    )
                )
            }
            
            return sa
            
        }
        catch{
            print("PB OCCURRED IN FETCH PARSE")
            
        }
        return nil
        
    }
    
    class func getServiceAskerList()->[ServiceAsker]!{
        return sharedInstance.goGetServiceAskerList()
    }

    
    /////////////////////////////////////////////////////////

    
    private func goGetServiceAskerListNearGeoPoint(geoPoint:PFGeoPoint)->[ServiceAsker]{
        
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        
        let query = PFQuery(className:"ServiceAsker");
        query.whereKey("geoPoint", nearGeoPoint: geoPoint, withinKilometers: 50.0)
        
        var objects:[PFObject]!
        var sas:[ServiceAsker] = [ServiceAsker]()
        do{
            try objects = query.findObjects()
            print("OBJECTS RETRIEVED : \(objects)")
            for object in objects{
                //let sa = ServiceAskerManager.getServiceAskerWithId(object.objectId!) as ServiceAsker!
                let sa  =   ServiceAsker.createServiceAsker(
                    object.objectId!,
                    newAddress:object["address"] as! String,
                    newName:object["name"] as! String,
                    newSurname:object["surname"] as! String,
                    newPhone:(object["phone"] as? String)!,
                    newEmail:(object["email"] as? String)!,
                    newNotation:object["notation"] as! Int,
                    newDisabledSPs:object["disabledSPs"] as! [String],
                    newGeoPoint:object["geoPoint"] as! PFGeoPoint,
                    newServices:object["services"] as! [String]
                )

                sas.append(sa)
            }
        }catch{
            print("ERROR IN FETCHING OBJECTS NEAR ME")
        }
        
        return sas
    }
    
    class func getServiceAskerListNearGeoPoint(geoPoint:PFGeoPoint)->[ServiceAsker]{
        return sharedInstance.goGetServiceAskerListNearGeoPoint(geoPoint)
    }

    /////////////////////////////////////////////////////////

    
    private func update(sa:ServiceAsker){
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        let query = PFQuery(className:"ServiceAsker")
        query.whereKey("address", equalTo: "\(sa.address)")
        var object: PFObject!
        
        do{
            try object = query.getFirstObject()
            object["address"]     = sa.address
            object["name"]        = sa.name
            object["surname"]     = sa.surname
            object["phone"]       = sa.phone
            object["email"]       = sa.email
            object["notation"]    = sa.notation
            object["disabledSPs"] = sa.disabledSPs
            object["geoPoint"]    = sa.geoPoint
            object["services"]    = sa.services
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
    
    class func update(sa:ServiceAsker){
        sharedInstance.update(sa)
    }

    /////////////////////////////////////////////////////////

    
    @objc func save(notification:NSNotification){
        
        // VALIDATION FIRST
        
        print("save \(notification.object?.description)")
        var string:String = (notification.object?.description)!
        print("Formatting not object to string: \(string)")
        save(ObjectPoolForServiceAsker.getFromPool(string)!)
            print("save HERE")

        NSNotificationCenter.defaultCenter().removeObserver(self, name: "net.canatac.hommeatoutfaire.serviceasker.geopoint.ok", object: nil)
        
        
    }
    
    class func save(notification:NSNotification){
        sharedInstance.save(notification)
    }

    /////////////////////////////////////////////////////////

    
    private func save(sa:ServiceAsker){
        // Initialize Parse.
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        let saObject = PFObject(className: "ServiceAsker")
        saObject["address"]     = sa.address
        saObject["name"]        = sa.name
        saObject["surname"]     = sa.surname
        saObject["phone"]       = sa.phone
        saObject["email"]       = sa.email
        saObject["notation"]    = sa.notation
        saObject["disabledSPs"] = sa.disabledSPs
        saObject["geoPoint"]    = sa.geoPoint
        saObject["services"]    = sa.services

        //        saObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
/*
        do{
            try saObject.save()
                        print("SA Object has been saved.")

        }catch{
            print("PB OCCURED WHEN SAVING SA")
        }

*/
        saObject.saveInBackgroundWithBlock{(success: Bool, error:NSError?)-> Void in                NSNotificationCenter.defaultCenter().postNotificationName("net.canatac.hommeatoutfaire.serviceactormg.save.ok", object: nil)
        }

    }
    
    
    class func save(sa:ServiceAsker){
        sharedInstance.save(sa)
    }
   

    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////

    
    class var sharedInstance:ServiceAskerManager{
        get {
            struct SingletonWrapper {
                static let singleton = ServiceAskerManager()
            }
            return SingletonWrapper.singleton
        }
    }
}