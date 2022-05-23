//
//  MockService.swift
//  MapProjectTests
//
//  Created by Sarad Chhetri on 23/5/2022.
//

import Foundation
@testable import MapProject

class MockService : ServiceProtocol {

    
    let mockData: LocationData?
    
    init(mockData: LocationData?) {
        self.mockData = mockData
    }
    
    func fetchLocationDatas(completion: @escaping (LocationData?) -> Void) {
            completion(mockData)
    }

}
