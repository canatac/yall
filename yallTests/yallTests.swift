//
//  yallTests.swift
//  yallTests
//
//  Created by Can ATAC on 05/10/2015.
//  Copyright © 2015 Can ATAC. All rights reserved.
//

import XCTest

@testable import yall

class yallTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Initialize Parse.
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
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
        
        assert(serviceAsker.address==address,"SA Created with address")
        
        
        
    }
    
    func testCreateSP(){
        
        let address = "674 Inönü Caddesi, Izmir, Turquie"

        let email = "can.atac@gmail.com"
        let phone = "236"

        let serviceProvider = ServiceProvider.createServiceProvider(address, newName: "Can3", newSurname:"ATAC", newEmail:email, newPhone:phone)
        
        print ("Service provider created at :\(serviceProvider.address)")
        sleep(10)
        assert(serviceProvider.address==address,"SP Created with address")

    }

    func testGetSAWithAddress(){
        
        //ServiceAsker.createServiceAsker("121 Rue Henri Barbusse, 92110 CLICHY", newName: "TEST3")
        let sa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        print("Service asker retrieved : \(sa.name)")
        
        
    }
    func testGetSPWithAddress(){
        //ServiceProvider.createServiceProvider("226 Boulevard Anatole France, 93200 ST-DENIS", newName: "Can ATAC")
        
        let sp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        print("Service provider retrieved : \(sp.name)")
    }
    func testGetSAWithId(){
        
        //ServiceAsker.createServiceAsker("121 Rue Henri Barbusse, 92110 CLICHY", newName: "TEST3")
        let sa = ServiceAskerManager.getServiceAskerWithId("Lq2XZXbArP") as ServiceAsker!
        print("Service asker retrieved : \(sa.name)")
        
        
    }
    func testGetSPWithId(){
        
        //ServiceAsker.createServiceAsker("121 Rue Henri Barbusse, 92110 CLICHY", newName: "TEST3")
        let sa = ServiceProviderManager.getServiceProviderWithId("JbeXX4Qjxd") as ServiceProvider!
        print("Service provider retrieved : \(sa.name)")
        
        
    }
    func testGetSAList(){

        let saList = ServiceAskerManager.getServiceAskerList() as [ServiceAsker]!
        for sa in saList{
            print("Service asker list : \(sa.name)")

        }
        
        
    }
    func testGetSPList(){
        let address = "226 Boulevard Anatole France, 93200 ST-DENIS"

        let spList = ServiceProviderManager.getServiceProviderList(address) as [ServiceProvider]!
        for sp in spList{
            print("Service provider list : \(sp.name)")
            
        }
    }
    
    func testGiveANoteToSA(){
        
        let oldSa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        print("Service asker retrieved name - notation: \(oldSa.name) - \(oldSa.notation)")
        
        oldSa.notation = 110
        ServiceAskerManager.update(oldSa)
        
        
        let updatedSa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        print("Service asker retrieved name - notation: \(updatedSa.name) - \(updatedSa.notation)")
        
    }
    func testGiveANoteToSP(){
        let sp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        print("Service provider retrieved name - notation : \(sp.name) - \(sp.notation)")
        
        sp.notation =   5
        
        ServiceProviderManager.update(sp)
        
        let updatedSp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        print("Service provider retrieved name - notation: \(updatedSp.name) - \(updatedSp.notation)")
        
    }

    func testGetServiceList(){
        let services = ServicesManager.getList() as [Service]!
        for sp in services{
            print("Services list : \(sp.label)")
            
        }
    }
    
    func testGetServiceListById(){
        let serviceIds:[String] = ["BoFbg3RFOk","0ftV2Mcuer","QNgyOq12BA"]
        let services = ServicesManager.getList(serviceIds)
        for sp in services{
            print("Services list : \(sp.label)")
            
        }
        
    }
    
    func testDisableSA(){
        // The SP
    }
    func testDisableSP(){
        //ServiceAsker.createServiceAsker("VILLEMER", newName: "DADA")
        
        // The SA has selected one SP to add to his disabled SPs
        let sa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        print("Service asker retrieved : \(sa.name)")

        let sp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        print("Service provider retrieved to disable : \(sp.name)")

        sa.disabledSPs.append(sp.serviceProviderId)
        
        let updatedSa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        updatedSa.disabledSPs = sa.disabledSPs
        
        ServiceAskerManager.update(updatedSa)
        
    }
    func testEnableSA(){
        
        
    }
    func testEnableSP(){
    
        let sa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        print("Service asker retrieved : \(sa.name)")
        
        let sp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        print("Service provider retrieved to enable : \(sp.name)")
        
        for (index, value) in sa.disabledSPs.enumerate() {
            print("Item \(index + 1): \(value)")
            let spRetrieved = value as String!
            if (spRetrieved == sp.serviceProviderId){
                sa.disabledSPs.removeAtIndex(index)
                break
            }
        }
        
        
        let updatedSa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        updatedSa.disabledSPs = sa.disabledSPs
        
        ServiceAskerManager.update(updatedSa)
    }
    
    func testAddServiceToSA(){
        let sa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        print("Service asker retrieved : \(sa.name)")
        
        // GET SERVICES LIST
        let services = ServicesManager.getList() as [Service]!
        // PICK ALL
        for service in services{
            print("Services list : \(service.label)")
            sa.services.append(service.serviceId)
        }
        
        let updatedSa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        updatedSa.services = sa.services
        
        ServiceAskerManager.update(updatedSa)

    }
    func testAddServiceToSP(){
        let sp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        print("Service provider retrieved to enable : \(sp.name)")
        
        // GET SERVICES LIST
        let services = ServicesManager.getList() as [Service]!
        // PICK ALL
        for service in services{
            print("Services list : \(service.label)")
            sp.services.append(service.serviceId)
        }
        
        let updatedSp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        updatedSp.services = sp.services
        
        ServiceProviderManager.update(updatedSp)
    }
    func testRemoveAllServicesFromSA(){
        let sa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        print("Service asker retrieved to enable : \(sa.name)")
        
        // REMOVE ALL

        for var index = sa.services.count - 1; index >= 0; --index {
            sa.services.removeAtIndex(index)
        }
        let updatedSa = ServiceAskerManager.getServiceAskerWithAddress("121 Rue Henri Barbusse, 92110 CLICHY") as ServiceAsker!
        updatedSa.services = sa.services
        
        ServiceAskerManager.update(updatedSa)
    }
    func testRemoveAllServicesFromSP(){
        let sp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        print("Service provider retrieved to enable : \(sp.name)")
        
        // REMOVE ALL
        
        for var index = sp.services.count - 1; index >= 0; --index {
                sp.services.removeAtIndex(index)
        }
        let updatedSp = ServiceProviderManager.getServiceProviderWithAddress("226 Boulevard Anatole France, 93200 ST-DENIS") as ServiceProvider!
        updatedSp.services = sp.services
        
        ServiceProviderManager.update(updatedSp)
    }
    func testAddGeoPointToSA(){
        Parse.setApplicationId("ITZvBDCa8Dli79exPbgfc59hndUNPkrk22axXwt3",
            clientKey: "nM5sBIR7vW0DXOT2Qn92hXXypVmDeRqujHbWHw50")
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        let address = "121 Rue Henri Barbusse, 92110 CLICHY"
        
        CLGeocoder().geocodeAddressString(address,completionHandler: {(placemarks, error)->Void in
            if error == nil {
                let p = (placemarks?[0] as? CLPlacemark!)!
                let geoPoint = PFGeoPoint(location: p.location as CLLocation?)
                let oldSa = ServiceAskerManager.getServiceAskerWithAddress(address) as ServiceAsker!
                print("Service asker retrieved name - notation: \(oldSa.name) - \(oldSa.notation)")
                
                oldSa.geoPoint = geoPoint
                ServiceAskerManager.update(oldSa)
                
                let updatedSa = ServiceAskerManager.getServiceAskerWithAddress(address) as ServiceAsker!
                print("Service asker retrieved name - geoPoint: \(updatedSa.name) - \(updatedSa.geoPoint)")
                
                readyExpectation.fulfill()
            }
            else
            {
                print("NO GEOPOINT FOUND")
            }
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Error")
        })
   
    }
    func testAddGeoPointToSP(){
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        //let address = "226 Boulevard anatole france, 93200 ST-DENIS"
        let address = "674 Inönü Caddesi, Izmir, Turquie"

        
        CLGeocoder().geocodeAddressString(address,completionHandler: {(placemarks, error)->Void in
            if error == nil {
                let p = (placemarks?[0] as? CLPlacemark!)!
                let geoPoint = PFGeoPoint(location: p.location as CLLocation?)
                let oldSa = ServiceProviderManager.getServiceProviderWithAddress(address) as ServiceProvider!
                print("Service provider retrieved name - notation: \(oldSa.name) - \(oldSa.notation)")
                
                oldSa.geoPoint = geoPoint
                ServiceProviderManager.update(oldSa)
                
                
                let updatedSa = ServiceProviderManager.getServiceProviderWithAddress(address) as ServiceProvider!
                print("Service provider retrieved name - geoPoint: \(updatedSa.name) - \(updatedSa.geoPoint)")
                
                readyExpectation.fulfill()
            }
            else
            {
                print("NO GEOPOINT FOUND")
            }
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Error")
        })

    }
    func testGetSPListByGeoPoint(){
        let address = "121 Rue Henri Barbusse, 92110 CLICHY"
        
        let oldSa = ServiceAskerManager.getServiceAskerWithAddress(address) as ServiceAsker!
        print("Service asker retrieved name - notation: \(oldSa.name) - \(oldSa.notation)")
        let geopoint:PFGeoPoint = oldSa.geoPoint;
        let providersNearGeoPoint:[ServiceProvider]=ServiceProviderManager.getServiceProviderListNearGeoPoint(geopoint)
        for sp in providersNearGeoPoint{
            print("provider retrieved : \(sp.name)")
        }
    }
    func testGetSAListByGeoPoint(){
        let oldSa = ServiceProviderManager.getServiceProviderWithAddress("674 Inönü Caddesi, Izmir, Turquie") as ServiceProvider!
        print("Service provider retrieved name - notation: \(oldSa.name) - \(oldSa.notation)")
        let geopoint:PFGeoPoint = oldSa.geoPoint;
        let askersNearGeoPoint:[ServiceAsker]=ServiceAskerManager.getServiceAskerListNearGeoPoint(geopoint)
        for sp in askersNearGeoPoint{
            print("asker retrieved : \(sp.name)")
        }
    }
    
    func testGetSPListByLocationAPI(){
        let location:CLLocation = CLLocation(latitude: 48.90, longitude: 2.32)
        let providersNearGeoPoint:Dictionary<String,Dictionary<String,AnyObject>>=ServiceProviderFactory.getListWithMyLocation(location)

        for (_,value) in providersNearGeoPoint{
            let tmp:Dictionary<String,AnyObject> = value
            let n = tmp["name"]
            print("provider retrieved : \(n)")

        }
    }
    func testGetSAListByLocationAPI(){
        let location:CLLocation = CLLocation(latitude: 48.90, longitude: 2.32)
        let askersNearGeoPoint:Dictionary<String,Dictionary<String,AnyObject>>=ServiceAskerFactory.getListWithMyLocation(location)
        for (_,value) in askersNearGeoPoint{
            let tmp:Dictionary<String,AnyObject> = value
            let n = tmp["name"]
            print("asker retrieved : \(n)")
            
        }
    }

    func testCreatePFGeoPoint(){
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        let address = "121 Rue Henri barbusse, 92110 CLICHY"
        
        CLGeocoder().geocodeAddressString(address,completionHandler: {(placemarks, error)->Void in
            if error == nil {
                let p = (placemarks?[0] as? CLPlacemark!)!
                print(PFGeoPoint(location: p.location as CLLocation?))
                readyExpectation.fulfill()
            }
            else
            {
                print("NO GEOPOINT FOUND")
            }
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Error")
        })

        
        
    }
    
    func testEmailValidator(){
        let address = "35 rue de la jonquière, 75017 PARIS"
        let name = "Can10"
        let surname = "ATAC10"
        let email = ""
        let phone = "01.23.24.25.24"
        let serviceAsker = ServiceAsker.createServiceAsker(address, newName:name, newSurname:surname, newEmail:email, newPhone:phone)
        if EmailValidator().validate(serviceAsker) {
            
            print("Service asker created at : \(serviceAsker.address)")
        }else{
            print("EMAIL NOT VALID")
            
        }
        
        let address2 = "35 rue de la jonquière, 75017 PARIS"
        let name2 = "Can10"
        let surname2 = "ATAC10"
        let email2 = "can.atac@gmail.com"
        let phone2 = "01.23.24.25.24"
        let serviceAsker2 = ServiceAsker.createServiceAsker(address2, newName:name2, newSurname:surname2, newEmail:email2, newPhone:phone2)
        if EmailValidator().validate(serviceAsker2) {
            
            print("Service asker created at : \(serviceAsker2.address)")
        }else{
            print("EMAIL NOT VALID")

        }

        
    }
    
    func testPhoneValidator(){
        let address = "35 rue de la jonquière, 75017 PARIS"
        let name = "Can10"
        let surname = "ATAC10"
        let email = "can.atac@gmail.com"
        let phone = ""
        let serviceAsker = ServiceAsker.createServiceAsker(address, newName:name, newSurname:surname, newEmail:email, newPhone:phone)
        if PhoneValidator().validate(serviceAsker) {
            ServiceAskerManager.save(serviceAsker)
            print("Service asker created at : \(serviceAsker.address)")
        }else{
            print("PHONE NOT VALID")
            
        }
        let address2 = "35 rue de la jonquière, 75017 PARIS"
        let name2 = "Can10"
        let surname2 = "ATAC10"
        let email2 = "can.atac@gmail.com"
        let phone2 = "+33123242524"
        let serviceAsker2 = ServiceAsker.createServiceAsker(address2, newName:name2, newSurname:surname2, newEmail:email2, newPhone:phone2)
        if PhoneValidator().validate(serviceAsker2) {
            ServiceAskerManager.save(serviceAsker2)
            print("Service asker created at : \(serviceAsker2.address)")
        }else{
            print("PHONE NOT VALID")
            
        }
        let address3 = "35 rue de la jonquière, 75017 PARIS"
        let name3 = "Can10"
        let surname3 = "ATAC10"
        let email3 = "can.atac@gmail.com"
        let phone3 = "01.23.24.25.24"
        let serviceProvider = ServiceProvider.createServiceProvider(address3, newName:name3, newSurname:surname3, newEmail:email3, newPhone:phone3)
        if PhoneValidator().validate(serviceProvider) {
            ServiceProviderManager.save(serviceProvider)
            print("Service provider created at : \(serviceProvider.address)")
        }else{
            print("PHONE NOT VALID")
            
        }

    }
    
    func testNameValidator(){
        let address = "35 rue de la jonquière, 75017 PARIS"
        let name = ""
        let surname = "ATAC10"
        let email = "can.atac@gmail.com"
        let phone = ""
        let serviceAsker = ServiceAsker.createServiceAsker(address, newName:name, newSurname:surname, newEmail:email, newPhone:phone)
        if NameValidator().validate(serviceAsker) {
            ServiceAskerManager.save(serviceAsker)
            print("Service asker created at : \(serviceAsker.address)")
        }else{
            print("NAME NOT VALID")
            
        }
        let address2 = "35 rue de la jonquière, 75017 PARIS"
        let name2 = "Can10"
        let surname2 = "ATAC10"
        let email2 = "can.atac@gmail.com"
        let phone2 = "01.23.24.25.24"
        let serviceAsker2 = ServiceAsker.createServiceAsker(address2, newName:name2, newSurname:surname2, newEmail:email2, newPhone:phone2)
        if NameValidator().validate(serviceAsker2) {
            ServiceAskerManager.save(serviceAsker2)
            print("Service asker created at : \(serviceAsker2.address)")
        }else{
            print("NAME NOT VALID")
            
        }
        let address3 = "35 rue de la jonquière, 75017 PARIS"
        let name3 = "Can10"
        let surname3 = "ATAC10"
        let email3 = "can.atac@gmail.com"
        let phone3 = "01.23.24.25.24"
        let serviceProvider = ServiceProvider.createServiceProvider(address3, newName:name3, newSurname:surname3, newEmail:email3, newPhone:phone3)
        if NameValidator().validate(serviceProvider) {
            ServiceProviderManager.save(serviceProvider)
            print("Service provider created at : \(serviceProvider.address)")
        }else{
            print("NAME NOT VALID")
            
        }
        
    }

    func testServiceActorValidator(){
        let address = "35 rue de la jonquière, 75017 PARIS"
        let name = "CANTEST"
        let surname = ""
        let email = ""
        let phone = ""
        let serviceAsker = ServiceAsker.createServiceAsker(address, newName:name, newSurname:surname, newEmail:email, newPhone:phone)
        if ServiceActorValidator().validate(serviceAsker) {
            ServiceAskerManager.save(serviceAsker)
            print("Service asker created at : \(serviceAsker.address)")
        }else{
            print("SERVICEACTOR NOT VALID")
            
        }
        let address2 = "35 rue de la jonquière, 75017 PARIS"
        let name2 = "Can10"
        let surname2 = "ATAC10"
        let email2 = "can.atac@gmail.com"
        let phone2 = "01.23.24.25.24"
        let serviceAsker2 = ServiceAsker.createServiceAsker(address2, newName:name2, newSurname:surname2, newEmail:email2, newPhone:phone2)
        if ServiceActorValidator().validate(serviceAsker2) {
            ServiceAskerManager.save(serviceAsker2)
            print("Service asker created at : \(serviceAsker2.address)")
        }else{
            print("SERVICEACTOR NOT VALID")
            
        }
        let address3 = "35 rue de la jonquière, 75017 PARIS"
        let name3 = "Can10"
        let surname3 = "ATAC10"
        let email3 = "can.atac@gmail.com"
        let phone3 = "01.23.24.25.24"
        let serviceProvider = ServiceProvider.createServiceProvider(address3, newName:name3, newSurname:surname3, newEmail:email3, newPhone:phone3)
        if ServiceActorValidator().validate(serviceProvider) {
            ServiceProviderManager.save(serviceProvider)
            print("Service provider created at : \(serviceProvider.address)")
        }else{
            print("SERVICEACTOR NOT VALID")
            
        }

    
    }
    
    func testServiceActorValidatorWithResponse(){
        
        let address = "35 rue de la jonquière, 75017 PARIS"
        let name = "Can"
        let surname = "ATAC"
        let email = "sfc"
        let phone = ""
        let serviceAsker = ServiceAsker.createServiceAsker(address, newName:name, newSurname:surname, newEmail:email, newPhone:phone)
        if let response:[String:String] = ServiceActorValidator().validateAndResponse(serviceAsker) as! [String:String]{
            
            for key in response.keys {
                print("DONE response : \(key) - \(response[key]!)")
            }
        }
        else
        {
            print("SOMETHING IS WRONG")
        }
    
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            
        }
    }
}
