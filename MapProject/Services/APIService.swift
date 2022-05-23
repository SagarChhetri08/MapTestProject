//
//  APIService.swift
//  MapProject
//
//  Created by Sarad Chhetri on 23/5/2022.
//

import Foundation
import SwiftUI
import MapKit

class APIService : ServiceProtocol {
    
    func fetchLocationDatas(completion: @escaping (LocationData?) -> Void) {
        loadDataFromResources(completion: completion)
    }
    
    private func loadDataFromResources(completion: @escaping (LocationData?) -> Void){
        guard let assets = NSDataAsset(name: "LocationsJsonData") else {
              print("Missing data asset: LocationsJsonData")
            completion(nil)
            return
        }
        
        guard let locations = try? JSONDecoder().decode(LocationData.self, from: assets.data) else {
            completion(nil)
            return
        }
        
        DispatchQueue.main.async {
            completion(locations)
        }
        
    }
}
