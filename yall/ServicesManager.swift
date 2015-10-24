//
//  ServicesManager.swift
//  yall
//
//  Created by Can ATAC on 05/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import Parse

class ServicesManager{
    class func getList()->[Service]!{
        let query = PFQuery(className:"Service")
        var objects: [PFObject]!
        var services = [Service]()
        
        do{
            try objects = query.findObjects()
            for service in objects{
                services.append(Service.createService((service.objectId as? String!)! ,newLabel:service["label"] as! String))
            }
        }
        catch{
            print("PB RETRIEVING SERVICES")
        }
        
        return services

    }
    class func getList(serviceIds:[String])->[Service]!{
        let query = PFQuery(className:"Service")
        var services = [Service]()
        var service:PFObject

        for serviceId in serviceIds{
                        do{
                            try service = query.getObjectWithId(serviceId)
                            services.append(Service.createService(serviceId ,newLabel:service["label"] as! String))
                        }
                        catch{
                            print("PB RETRIEVING SERVICES BY ID")
                        }
        }
        return services
        
    }
    
    class func getListNames(serviceIds:[String])->[String]!{
        let query = PFQuery(className:"Service")
        var serviceNames = [String]()
        var service:PFObject
        
        for serviceId in serviceIds{
            do{
                try service = query.getObjectWithId(serviceId)
                serviceNames.append(service["label"] as! String)
            }
            catch{
                print("PB RETRIEVING SERVICES BY ID")
            }
        }
        return serviceNames
        
    }

}