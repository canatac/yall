//
//  VersionValidator.swift
//  yall
//
//  Created by Can ATAC on 20/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation

class VersionValidator{

    private func validate(appVersionToValidate:String)->Bool{
        let bundle = NSBundle(identifier: "net.canatac.yall")!
        // Get app version number
        
        let appVersion = bundle.objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        
        let appVersionFloat:Float = (appVersion as NSString!).floatValue
        
        let pattern = "\\d{1,9}?\\.\\d{1,9}?"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        if predicate.evaluateWithObject(appVersionToValidate){
            
            let appVersionToValidateFloat:Float = (appVersionToValidate as NSString!).floatValue

            if appVersionToValidateFloat == appVersionFloat {
                return true
            }else{
                return false
            }
        }
        print("INVALIDATE FORMAT")
        return false
    }
    
    typealias CompletionHandler = (result:Bool) -> Void
    
    func validateDataWithCompletion(data:String,completionHandler: CompletionHandler) {
        var flag:Bool = false
        // data validation.....
        if self.validate(data) {
            print("THERE - NO UPDATE REQUIRED")
            flag = true
        }else{
            print("THERE - DOWNLOAD LATEST VERSION")
        }
        
        // true if download succeed,false otherwise
        
        completionHandler(result: flag)
    }
}
