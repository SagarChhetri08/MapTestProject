//
//  LocationListTest.swift
//  MapProjectTests
//
//  Created by Sarad Chhetri on 23/5/2022.
//

import XCTest
@testable import MapProject

class LocationListTest: XCTestCase {

    func testSuccessParser(){
        let json = """
        {
              "locations": [
                {
                    "typeId": 0,
                    "departureTime": "2021-07-03T09:10:00.000Z",
                    "name": "Flinders",
                    "latitude": -37.8181755,
                    "longitude": 144.9661256 },
                {
                    "typeId": 0,
                    "departureTime": "2021-07-03T14:30:00.000Z",
                    "name": "Flinders",
                    "latitude": -37.8181755,
                    "longitude": 144.9661256,
                    "isExpress": true }] }
        """.data(using: .utf8)!

        
        let locations = try! JSONDecoder().decode(LocationData.self, from: json)
        
        XCTAssertNotNil(locations)
        
    }

}
