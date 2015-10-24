//
//  ServiceActorAPI.swift
//  yall
//
//  Created by Can ATAC on 25/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation

public class ServiceActorAPI{

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