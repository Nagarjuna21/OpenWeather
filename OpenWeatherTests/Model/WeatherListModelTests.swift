//
//  WeatherListModelTests.swift
//  OpenWeatherTests
//
//  Created by Nagarjuna Madamanchi on 24/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

import XCTest
@testable import OpenWeather

class WeatherListModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ShouldSetWeatherValues(){
        let sut = List(timeInterval: 4734834, headshot: "Title", maxTemparature: 23.02, minTemparature:43.00, weatherTitle: "Cold", dateTxt: "23-06-2010")
        XCTAssertEqual(sut.headshot, "Title")
        XCTAssertEqual(sut.weatherTitle, "Cold")
        XCTAssertEqual(sut.dateTxt, "23-06-2010")
    }
    
}
