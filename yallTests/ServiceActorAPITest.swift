//
//  ServiceActorAPI.swift
//  yall
//
//  Created by Can ATAC on 25/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import XCTest
@testable import yall

class ServiceActorAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateServiceProvider() {
        let formData:[String:String]    =   [
        "name":"joe",
        "surname":"biden",
        "email":"can.atac@gmail.com",
        "address":"121 Rue Henri Barbusse 92110 CLICHY",
        "phone":"+33623243101"]
        
        ServiceActorAPI.createServiceActor("PROVIDER",formData:formData)
        
    }
    
    func textCreateServiceAsker(){
        let formData:[String:String]    =   [
        "name":"joe",
        "surname":"biden",
        "email":"can.atac@gmail.com",
        "address":"121 Rue Henri Barbusse 92110 CLICHY",
        "phone":"+33623243101"]
        
        ServiceActorAPI.createServiceActor("ASKER",formData:formData)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
