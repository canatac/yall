//
//  Service.swift
//  yall
//
//  Created by Can ATAC on 05/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation

class Service{

    private var serviceIdBV:String
    private var labelBV:String
    
    final var label:String{
        get{return self.labelBV}
    }
    
    final var serviceId:String{
        get{return self.serviceIdBV}
    }
    private init(serviceId:String,label:String){
        self.serviceIdBV    =   serviceId
        self.labelBV        =   label
    }
    
    class func createService(newServiceId:String,newLabel:String)->Service!{
        var sp : Service!
        sp = Service(serviceId:newServiceId,label: newLabel)
        return sp
    }

}