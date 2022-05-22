//
//  LocationsViewModel.swift
//  MapProject
//
//  Created by Sarad Chhetri on 22/5/2022.
//

import Foundation
import SwiftUI
import MapKit


class LocationsViewModel : ObservableObject {
    @Published var locations: LocationData?
    @Published var filteredLocations: LocationData?
    @Published var mapRegion = MKCoordinateRegion()
    let defaultLocation = Location(typeID: 0, departureTime: "2021-07-03T14:30:00.000Z", name: "Flinders", latitude: -37.8181755, longitude: 144.9661256, isExpress: true, route: nil, hasMyKiTopUp: nil)
    
    init(){
        guard let assets = NSDataAsset(name: "LocationsJsonData") else {
              print("Missing data asset: LocationsJsonData")
            return
        }
        
        let locations = try! JSONDecoder().decode(LocationData.self, from: assets.data)
        self.locations = locations
        self.filteredLocations = locations
        
 
        self.updateMapRegion(location: locations.locations.first ?? defaultLocation)

    }
    private func updateMapRegion(location : Location){
        self.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    }
    func convertStingDate(dateString: String) -> String{
          
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date2 = formatter1.date(from: dateString) {
            let formatter2 = DateFormatter()
            formatter2.dateFormat = " dd MMM yy HH:mm"
        
            let datestring = formatter2.string(from: date2)
              
            print("The Modified Date \(dateString)")
            return datestring
        }
        return dateString
    }
    
    func showAllData(){
        if let data = locations {
            self.filteredLocations = locations
        }
    }
    
    func filterLocations(filter:FilterType , isTrue : Bool){
        if let data = locations {
            filteredLocations?.locations.removeAll()
            var transportdata = [Location]()
            var mykidata = [Location]()
            var expressdata = [Location]()
            switch filter{
            case .transport:
                
                if isTrue{
                    transportdata = data.locations.filter{ $0.typeID == 0  }
                }else{
                    transportdata = data.locations.filter{ $0.typeID == 1  }
                }
            case .express:
              
                if isTrue{
                     expressdata = data.locations.filter{ $0.isExpress == true }
                }else{
                    expressdata = data.locations.filter{ $0.isExpress == false }
                }
     
            case .topup:
            
                if isTrue{
                     mykidata = data.locations.filter{ $0.hasMyKiTopUp == true }
                }else{
                     mykidata = data.locations.filter{ $0.hasMyKiTopUp == false }
                }
            }
            self.filteredLocations?.locations =  expressdata + transportdata + mykidata
        }

    }

    
}
