//
//  ServiceAskerTest.swift
//  yall
//
//  Created by Can ATAC on 14/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import XCTest

@testable import yall

class ServiceAskerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        // In UI tests it is usually best to stop immediately when a failure occurs.
        //continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateSA() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let address = "674 Inönü Caddesi, Izmir, Turquie"
        let    serviceAsker   =   ServiceAsker.createServiceAsker(address, newName: "Can", newSurname:"ATAC", newEmail:"123456", newPhone:"1234567890")
        
        print("Service asker created at : \(serviceAsker.address)")
        
        XCTAssert(serviceAsker.address==address,"SA Created with address")
        
    }


}
