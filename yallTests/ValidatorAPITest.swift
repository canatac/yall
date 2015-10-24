//
//  ValidatorAPITest.swift
//  yall
//
//  Created by Can ATAC on 21/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import XCTest
@testable import yall

class ValidatorAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyPhone() {
        
        let expectation = expectationWithDescription("testBasic")
        
        let data = ["Phone":"","Address":"121 Rue Henri Barbusse 92110 CLICHY","Name":"Can","Surname":"Atac","Email":"can.atac@gmail.com"]
        
        
        func delay(delay:Double, closure:()->()){
            dispatch_after(dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay*Double(NSEC_PER_SEC))
                ), dispatch_get_main_queue(), closure)
        }
        
        ValidatorAPI().validateAllDataWithCompletion(data, completionHandler: { (result,error) -> Void in
            
            // When // data validation completes,control flow goes here.
            
            delay(3.0){        // SIMULATE LONG CALL AND COMPLETION HANDLER
                
                if result.0 {
                    print("testBasic : result of validation with completion : \(result.0)")
                } else {
                    print("testBasic : result of validation with completion : \(result.0)")
                    for key in result.1.keys {
                        print("Dic Results : \(key)-\(result.1[key]!)")
                    }
                    
                }
                if (error != nil) {
                    print("testBasic ERROR : \(error)")
                }
                expectation.fulfill()
                
            }
            
        })
        
        print("END OF TEST - Completion code is running")
        waitForExpectationsWithTimeout(5, handler: nil)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
