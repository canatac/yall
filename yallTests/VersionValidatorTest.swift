//
//  VersionValidator.swift
//  yall
//
//  Created by Can ATAC on 20/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import XCTest
@testable import yall

class VersionValidatorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAppVersionWithCompletion(){
        
        let appVersion:String = "1.1"
        
        VersionValidator().validateDataWithCompletion(appVersion, completionHandler: { (result) -> Void in
            
            // When // data validation completes,control flow goes here.
            
            if result {
                print("TRUE : result of validation with completion : \(result)")
            } else {
                print("FALSE : result of validation with completion : \(result)")

            }
        })

    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
