
//
//  ValidatorAPI.swift
//  yall
//
//  Created by Can ATAC on 21/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import regex

public class ValidatorAPI{
    
    public init(){}
    
    public typealias CompletionHandlerForAllData = (result:(Bool,[String:Bool]), error:ErrorType?) throws -> Void
    
    public func validateAllDataWithCompletion(data:[String:String],completionHandler: CompletionHandlerForAllData) {
        RegexAPI().validateAllDataWithCompletion(data, completionHandler: {result,error in
            do{
                try
                    completionHandler(result: result,error: error)
            }catch{}
        })
        
    }


}