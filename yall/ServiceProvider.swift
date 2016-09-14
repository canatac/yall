//
//  ServiceProvider.swift
//  yall
//
//  Created by Can ATAC on 05/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import Parse

class ServiceProvider:ServiceActor{
    internal    var idBV:String
    private     var addressBV:String
    internal    var nameBV:String
    internal    var surnameBV:String
    internal    var phoneBV:String
    internal    var emailBV:String
    private     var notationBV:Int
    private     var geoPointBV:PFGeoPoint
    private     var servicesBV:[String]
    private     var udidBV:String
    
    private init(address:String, name:String, surname:String, email:String, phone:String, notation:Int, services:[String], geoPoint:PFGeoPoint ){
        
        let id = Int(rand())
        self.idBV                   =   String(id)
        self.addressBV              =   address
        self.nameBV                 =   name
        self.surnameBV              =   surname
        self.phoneBV                =   phone
        self.emailBV                =   email
        self.notationBV             =   notation
        self.geoPointBV             =   geoPoint
        self.servicesBV             =   services
        self.udidBV                 =   UIDevice.currentDevice().identifierForVendor!.UUIDString

        ObjectPoolForServiceProvider.returnToPool(self)
        
        NSNotificationCenter.defaultCenter().addObserver(ServiceProviderManager.sharedInstance,
            selector: "save:",
            name: "net.canatac.hommeatoutfaire.serviceprovider.geopoint.ok",
            object: nil)
        
        CLGeocoder().geocodeAddressString(address,completionHandler: {(placemarks, error)->Void in
            if error == nil {
                let p = (placemarks?[0] as? CLPlacemark!)!
                let itemFromPool:ServiceProvider = ObjectPoolForServiceProvider.getFromPool(String(id))!
                
                itemFromPool.geoPointBV = PFGeoPoint(location: p.location as CLLocation?)
                ObjectPoolForServiceProvider.returnToPool(itemFromPool)
                // SEND A NOTIFICATION TO SAVE SERVICEPROVIDER
                NSNotificationCenter.defaultCenter().postNotificationName("net.canatac.hommeatoutfaire.serviceprovider.geopoint.ok", object: id)
            }
        })
  
    }
    private init(serviceProviderId:String,address:String, name:String, surname:String, phone:String, email:String,notation:Int, services:[String], geoPoint:PFGeoPoint){
        self.idBV                   =   serviceProviderId
        self.addressBV              =   address
        self.nameBV                 =   name
        self.surnameBV              =   surname
        self.phoneBV                =   phone
        self.emailBV                =   email
        self.notationBV             =   notation
        self.servicesBV             =   services
        self.geoPointBV             =   geoPoint
        self.udidBV                 =   UIDevice.currentDevice().identifierForVendor!.UUIDString
    }
    var serviceProviderId:String{
        get{return self.idBV}
        set{ self.idBV = newValue}
    }
    final var address:String{
        get{return self.addressBV}
    }
    final var name:String{
        get{return self.nameBV}
    }
    final var surname:String{
        get {return surnameBV}
    }
    final var phone:String{
        get{return phoneBV}
    }
    final var email:String{
        get {return emailBV}
    }
    
    var notation:Int{
        get{return self.notationBV}
        set{ self.notationBV = newValue}
    }
    
    var services:[String]{
        get{return self.servicesBV}
        set{self.servicesBV =   newValue}
    }
    
    var udid:String{
        get{return self.udidBV}
        set{self.udidBV =   newValue}
    }
    
    var geoPoint:PFGeoPoint{
        get{return self.geoPointBV}
        set{self.geoPointBV = newValue}
    }

    func accept(validator:Validator){
        validator.validate(self)
    }
    
    func equals(id: String)->Bool {
        if self.idBV == id{return true}
        return false
    }
    // NEW
    class func createServiceProvider(newAddress:String, newName:String, newSurname:String, newEmail:String, newPhone:String, newNotation:Int, newServices:[String], newGeoPoint:PFGeoPoint)->ServiceProvider!{
        var sp : ServiceProvider!
        sp = ServiceProvider(address:newAddress, name:newName, surname:newSurname, email:newEmail, phone:newPhone, notation:newNotation, services:newServices, geoPoint:newGeoPoint)
        
        return sp
    }
    
    // OLD
    class func createServiceProvider(serviceProviderId:String,newAddress:String, newName:String, newSurname:String, newPhone:String,newEmail:String, newNotation:Int, newServices:[String], newGeoPoint:PFGeoPoint)->ServiceProvider!{
        var sp : ServiceProvider!
        sp = ServiceProvider(serviceProviderId:serviceProviderId,address:newAddress, name:newName, surname:newSurname, phone:newPhone,email:newEmail, notation:newNotation, services:newServices, geoPoint:newGeoPoint)
        return sp
    }

    class func deleteServiceProvider(actorId:String){
        ServiceProviderManager.delete(actorId)
    }
    
}