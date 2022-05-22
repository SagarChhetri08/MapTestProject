//
//  LocationData.swift
//  MapProject
//
//  Created by Sarad Chhetri on 22/5/2022.
//

import Foundation

// MARK: - LocationData
struct LocationData: Codable ,Equatable {

    
    var locations: [Location]
    static func == (lhs: LocationData, rhs: LocationData) -> Bool {
        return lhs.locations == rhs.locations
    }
}

// MARK: - Location
struct Location: Codable ,Equatable, Identifiable{
    let typeID: Int
    let departureTime, name: String
    let latitude, longitude: Double
    let isExpress: Bool?
    let route: String?
    let hasMyKiTopUp: Bool?
    var id : String {
        name + departureTime
    }
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case typeID = "typeId"
        case departureTime, name, latitude, longitude, isExpress, route, hasMyKiTopUp
    }
}
