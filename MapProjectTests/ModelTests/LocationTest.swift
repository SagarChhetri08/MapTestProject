//
//  LocationTest.swift
//  MapProjectTests
//
//  Created by Sarad Chhetri on 23/5/2022.
//

import XCTest
@testable import MapProject
class LocationTest: XCTestCase {

    func testSuccessParser(){
        let json = """
        {
            "typeId": 0,
            "departureTime": "2021-07-03T14:30:00.000Z",
            "name": "Flinders",
            "latitude": -37.8181755,
            "longitude": 144.9661256,
            "isExpress": true }
        """.data(using: .utf8)!

        
        let location = try! JSONDecoder().decode(Location.self, from: json)
        
        XCTAssertNotNil(location)
        
    }

}
