//
//  LocationViewModelTests.swift
//  MapProjectTests
//
//  Created by Sarad Chhetri on 23/5/2022.
//

import XCTest
@testable import MapProject

class LocationViewModelTests: XCTestCase {
    let dummyLocation = Location(typeID: 0, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: true, route: nil, hasMyKiTopUp: nil)
    let dummyLocations = [Location(typeID: 0, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: true, route: nil, hasMyKiTopUp: nil),
        Location(typeID: 0, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: true, route: nil, hasMyKiTopUp: nil),
        Location(typeID: 0, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: false, route: nil, hasMyKiTopUp: nil),
                          
        Location(typeID: 1, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: true, route: nil, hasMyKiTopUp: false),
        Location(typeID: 1, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: true, route: nil, hasMyKiTopUp: true),
        Location(typeID: 0, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: false, route: nil, hasMyKiTopUp: true)]
   
    func testSuccessFetchData() {

        let dummydata = LocationData(locations: [dummyLocation])
        let service = MockService(mockData: dummydata)
        
        let viewModel = LocationsViewModel(service: service)
        
        
        viewModel.loadData()
        
        XCTAssertNotNil(viewModel.locations)
        XCTAssertEqual(viewModel.locations?.locations.count, 1)
    }
    func testFilterData(){
        let dummydata = LocationData(locations: dummyLocations)
        let service = MockService(mockData: dummydata)
        
        let viewModel = LocationsViewModel(service: service)
        
        
        viewModel.filterLocations(filter: .transport, isTrue: false)
        
        XCTAssertNotNil(viewModel.filteredLocations)
        XCTAssertEqual(viewModel.filteredLocations?.locations.count, 2)
        
        viewModel.filterLocations(filter: .transport, isTrue: true)
        XCTAssertNotNil(viewModel.filteredLocations)
        XCTAssertEqual(viewModel.filteredLocations?.locations.count, 4)
        
        viewModel.filterLocations(filter: .express, isTrue: true)
        XCTAssertNotNil(viewModel.filteredLocations)
        XCTAssertEqual(viewModel.filteredLocations?.locations.count, 4)
        
        viewModel.filterLocations(filter: .express, isTrue: false)
        XCTAssertNotNil(viewModel.filteredLocations)
        XCTAssertEqual(viewModel.filteredLocations?.locations.count, 2)
        
        viewModel.filterLocations(filter: .topup, isTrue: true)
        XCTAssertNotNil(viewModel.filteredLocations)
        XCTAssertEqual(viewModel.filteredLocations?.locations.count, 2)
        
        viewModel.filterLocations(filter: .topup, isTrue: false)
        XCTAssertNotNil(viewModel.filteredLocations)
        XCTAssertEqual(viewModel.filteredLocations?.locations.count, 1)
    }

}
