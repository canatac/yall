//
//  Validator.swift
//  yall
//
//  Created by Can ATAC on 06/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import Foundation
import regex

protocol ServiceActor {
    var idBV:String{
        get set
    }
    var nameBV:String{
        get set
    }
    var name:String{
        get
    }
    var surnameBV:String{
        get set
    }
    var surname:String{
        get
    }
    var emailBV:String{
        get set
    }
    var email:String{
        get
    }
    var phoneBV:String{
        get set
    }
    var phone:String{
        get
    }
    func accept(validator:Validator)
    func equals(id:String)->Bool
}

protocol Validator{
    /*
    func validate(accept:ServiceAsker)->Bool
    func validate(accept:ServiceProvider)->Bool
    */
    var errors:[String:String]{get set}
    
    func validate(accept:ServiceActor)->Bool
    func validateWithResponse(accept:ServiceActor, var response:[String:String])->[String:String]

}
class ServiceActorValidator:Validator{
    
    var errors:[String:String]
    
    init(){
        self.errors = [String:String]()
    }
    
    func validate(accept: ServiceActor)->Bool {
        //var problem:Bool = false
        /*
        if  !NameValidator().validate(accept) {problem=true}
        if  !SurnameValidator().validate(accept) {problem=true}
        if  !EmailValidator().validate(accept){problem=true}
        if  !PhoneValidator().validate(accept){problem=true}
        
        if !problem
        {
            print("ServiceActorValidator : OK")
            return true
        }
        else{
            
            print("\(accept.name) NOT VALID")
            return false
        }
*/
        self.errors = NameValidator().validateWithResponse(accept, response: self.errors)
        self.errors = SurnameValidator().validateWithResponse(accept, response: self.errors)
        self.errors = EmailValidator().validateWithResponse(accept, response: self.errors)
        self.errors = PhoneValidator().validateWithResponse(accept, response: self.errors)
        
        return (self.errors.isEmpty) ? true:false
    }
    
    func validateWithResponse(accept: ServiceActor, response: [String:String])->[String:String] {
        let emptyDic:[String:String] = [String:String]()
        
        return validate(accept) ? emptyDic:self.errors
    }
    
    func validateAndResponse(accept:ServiceActor)->[String:String]{
        return validateWithResponse(accept, response: errors)
        /*
        var answer:Bool = validate(accept)
        return answer ?["TEST":"isOK"]:["TEST":"isKO"]
*/
    }
}
class NameValidator:Validator{
    
    var errors:[String:String]
    
    init(){
        self.errors = [String:String]()
    }
    func validate(accept: ServiceActor)->Bool {
        if accept.name.isEmpty{
            print("NameValidator : KO - NAME IS EMPTY")
            self.errors["Name"] = "Name is Empty"
            return false
        }else{
            print(accept.name)
            return true
        }
    }
    func validateWithResponse(accept: ServiceActor, var response: [String:String])->[String:String] {
        self.errors = response
        self.validate(accept)
        return self.errors
    }
    
}
class SurnameValidator:Validator{
    
    var errors:[String:String]
    
    init(){
        errors = [String:String]()
    }
    func validate(accept: ServiceActor)->Bool {
        if accept.surname.isEmpty{
            print("SurnameValidator : KO - NAME IS EMPTY")
            self.errors["Surname"] = "Surname is Empty"
            return false
        }else{
            print(accept.surname)
            return true
        }

    }
    func validateWithResponse(accept: ServiceActor, response: [String:String])->[String:String] {
        self.errors = response
        validate(accept)
        return self.errors
    }
    
}
class EmailValidator:Validator{
    
    var errors:[String:String]
    init(){
        errors = [String:String]()
    }
    func validate(accept:ServiceActor)->Bool{
        if accept.email.isEmpty{
            print("EmailValidator : KO - EMAIL IS EMPTY")
            self.errors["Email"] = "Email is Empty"
            return false
        }else{
            let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailToTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@",emailRegex)
            
            if emailToTest.evaluateWithObject(accept.email)
            {
                return true
            }
            else
            {
                print("NAME : \(accept.name) - EMAIL : \(accept.email)")
                self.errors["Email"] = "Email format error"
                return false
            }

        }
    }
    
    func validateWithResponse(accept: ServiceActor, response: [String:String])->[String:String] {
        self.errors = response
        validate(accept)
        return self.errors
    }
}
class PhoneValidator:Validator{
    
    var errors:[String:String]
    init(){
        errors = [String:String]()
    }
    func validate(accept: ServiceActor) ->Bool{
        
        do{
            let api = RegexAPI()
            try  api.validateWithResponse("Phone", value: accept.phone)
            if !api.errors.isEmpty{
                for key in api.errors.keys {
                    self.errors[key]=api.errors[key]
                }
                return false
            
            }
            return true
        }
        catch{
            print("REGEXAPI ERROR")
        }
        return false
        
        /*
        if accept.phone.isEmpty{
            print("PhoneValidator : KO - PHONE IS EMPTY")
            return false
        }else{
            print(accept.phone)
            return true
        }
*/

    }
    func validateWithResponse(accept: ServiceActor, response: [String:String])->[String:String] {
        self.errors = response
        validate(accept)
        return self.errors
    }
    
}
