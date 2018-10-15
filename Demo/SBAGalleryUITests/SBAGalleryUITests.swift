//
//  SBAGalleryUITests.swift
//  SBAGalleryUITests
//
//  Created by Shoaib Akhtar on 01/10/2018.
//  Copyright © 2018 Shoaib Akhtar. All rights reserved.
//

import XCTest

class SBAGalleryUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        flowCheck() 
    }
    
    func flowCheck() {
        let app = XCUIApplication()
        app.buttons["Open gallery"].tap()
        
        let collectionViewsQuery = app.collectionViews
        _ = collectionViewsQuery/*@START_MENU_TOKEN@*/.scrollViews.containing(.image, identifier:"1.jpg").element/*[[".cells.scrollViews.containing(.image, identifier:\"1.jpg\").element",".scrollViews.containing(.image, identifier:\"1.jpg\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        _ = collectionViewsQuery/*@START_MENU_TOKEN@*/.scrollViews.containing(.image, identifier:"2.jpg").element/*[[".cells.scrollViews.containing(.image, identifier:\"2.jpg\").element",".scrollViews.containing(.image, identifier:\"2.jpg\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        _ = collectionViewsQuery/*@START_MENU_TOKEN@*/.scrollViews.containing(.image, identifier:"3.jpg").element/*[[".cells.scrollViews.containing(.image, identifier:\"3.jpg\").element",".scrollViews.containing(.image, identifier:\"3.jpg\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
        app.buttons["Close"].tap()
    }

}
