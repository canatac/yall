//
//  ServiceAsker.swift
//  yall
//
//  Created by Can ATAC on 05/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import Parse

class ServiceAsker:ServiceActor{

    internal var idBV:String
    private var addressBV:String
    internal var nameBV:String

    internal var surnameBV:String
    internal var phoneBV:String
    internal var emailBV:String

    private var notationBV:Int
    private var disabledSPsBV:[String]
    private var geoPointBV:PFGeoPoint
    private var servicesBV:[String]
    private var udidBV:String

    private init(address:String, name:String, surname:String, email:String, phone:String, notation:Int, services:[String], geoPoint:PFGeoPoint){
        
        let id = Int(rand())
        self.idBV               =   String(id)
        self.addressBV          =   address
        self.nameBV             =   name
        self.surnameBV          =   surname
        self.phoneBV            =   phone
        self.emailBV            =   email
        self.notationBV         =   notation
        self.disabledSPsBV      =   [String]()
        self.geoPointBV         =   geoPoint
        self.servicesBV         =   services
        self.udidBV             =   UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        ObjectPoolForServiceAsker.returnToPool(self)
        
        NSNotificationCenter.defaultCenter().addObserver(ServiceAskerManager.sharedInstance,
            selector: "save:",
            name: "net.canatac.hommeatoutfaire.serviceasker.geopoint.ok",
            object: nil)
        
        CLGeocoder().geocodeAddressString(address,completionHandler: {(placemarks, error)->Void in
            if error == nil {
                let p = (placemarks?[0] as? CLPlacemark!)!
                //self.geoPointBV = PFGeoPoint(location: p.location as CLLocation?)
                let itemFromPool:ServiceAsker = ObjectPoolForServiceAsker.getFromPool(String(id))!
                
                itemFromPool.geoPointBV = PFGeoPoint(location: p.location as CLLocation?)
                ObjectPoolForServiceAsker.returnToPool(itemFromPool)
                // SEND A NOTIFICATION TO SAVE SERVICEASKER
                NSNotificationCenter.defaultCenter().postNotificationName("net.canatac.hommeatoutfaire.serviceasker.geopoint.ok", object: id)
            }
        })

    }
    private init(serviceAskerId:String,address:String, name:String, surname:String, phone:String, email:String, notation:Int, disabledSPs:[String],geoPoint:PFGeoPoint,services:[String]){
        self.idBV           =   serviceAskerId
        self.addressBV      =   address
        self.nameBV         =   name
        self.surnameBV      =   surname
        self.phoneBV        =   phone
        self.emailBV        =   email
        self.notationBV     =   notation
        self.disabledSPsBV  =   disabledSPs
        self.geoPointBV     =   geoPoint
        self.servicesBV     =   services
        self.udidBV         =   UIDevice.currentDevice().identifierForVendor!.UUIDString

    }
    var serviceAskerId:String{
        get{return self.idBV}
        set{ self.idBV = newValue}
    }
    
    final var address:String{
        get {return addressBV}
    }
    
    final var surname:String{
        get {return surnameBV}
    }
    final var name:String{
        get {return nameBV}
    }
    final var phone:String{
        get{return phoneBV}
    }
    final var email:String{
        get {return emailBV}
    }
    var notation:Int{
        get {return notationBV}
        set {self.notationBV = newValue}
    }
    var disabledSPs:[String]{
        get {return disabledSPsBV}
        set {self.disabledSPsBV = newValue}
    }
    var geoPoint:PFGeoPoint{
        get{return geoPointBV}
        set{self.geoPointBV = newValue}
    }
    var services:[String]{
        get{return servicesBV}
        set{self.servicesBV = newValue}
    }
    var udid:String{
        get{return udidBV}
        set{self.udidBV = newValue}
    }
    
    // NEW
    class func createServiceAsker(newAddress:String, newName:String, newSurname:String, newEmail:String, newPhone:String, newNotation:Int, newServices:[String], newGeoPoint:PFGeoPoint)->ServiceAsker!{
        var sa : ServiceAsker!
        sa = ServiceAsker(address:newAddress, name:newName, surname:newSurname, email:newEmail, phone:newPhone, notation:newNotation, services:newServices, geoPoint:newGeoPoint)
        
        return sa
    }
    // OLD
    class func createServiceAsker(serviceAskerId:String,newAddress:String, newName:String, newSurname:String, newPhone:String,newEmail:String, newNotation:Int, newDisabledSPs:[String], newGeoPoint:PFGeoPoint,newServices:[String])->ServiceAsker!{
        var sa : ServiceAsker!
        sa = ServiceAsker(serviceAskerId:serviceAskerId,address:newAddress, name:newName, surname:newSurname, phone:newPhone,email:newEmail, notation:newNotation, disabledSPs:newDisabledSPs, geoPoint:newGeoPoint,services:newServices)
        return sa
    }
    
    class func deleteServiceAsker(actorId:String){
        ServiceAskerManager.delete(actorId)
    }
    
    func accept(validator:Validator){
        validator.validate(self)
    }
    
    func equals(id:String)->Bool{
        if self.idBV == id{return true}
        return false
    }
    
}