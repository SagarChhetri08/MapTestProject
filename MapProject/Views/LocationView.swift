//
//  LocationView.swift
//  MapProject
//
//  Created by Sarad Chhetri on 22/5/2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @State var locationData : LocationData?
    @StateObject private var vm = LocationsViewModel()
    @State var showFilter = true
    @State var showAll = true
    @State var isTrain:Bool? = nil
    @State var isTram:Bool? = nil
    @State var isExpress:Bool? = nil
    @State var isMyKi:Bool? = nil
    
    

    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -37.8181755, longitude: 144.9661256), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    
    
    var body: some View {
        ZStack{
            
            if let data = locationData {
               
                Map(coordinateRegion: $vm.mapRegion, annotationItems: data.locations) { location in
                    MapAnnotation(coordinate:CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        
                        let transportType = (location.typeID == 0) ? "Train" : "Tram"
             
                        PlaceAnnotationView( title: location.name + " "+"( \(transportType) )", datetime: vm.convertStingDate(dateString: location.departureTime))
                    }
                }
                
                VStack{
                    VStack{
                        HStack{
                            Spacer()
                            Text("All")
                                .contextMenu {
                                    Button {
                                        showAll = true
                                        isTrain = false
                                        isExpress = false
                                        isMyKi = false
                                        print("All ")
                                        vm.showAllData()
                                    } label: {
                                        Label("Show All ", systemImage: (showAll == true ) ? "checkmark.circle" : "circle")
                                    }
                                  
                                }
                                .padding(.all , 6)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(4)
                            
                            Text("Filter By ").contextMenu{
                                
                                Text("Transport Type")
                                    .contextMenu {
                               
                        
                                        Button {
                                            isTrain = true
                                            showAll = false
                                            isExpress = nil
                                            isMyKi = nil
                                            vm.filterLocations(filter: .transport, isTrue: isTrain!)
                                        } label: {
                                            Label("Train Only ", systemImage: (isTrain == true ) ? "checkmark.circle" : "circle")
                                        }
                                        Button {
                                            
                                            isTrain = false
                                            showAll = false
                                            isExpress = nil
                                            isMyKi = nil
                                            print("Chose tram")
                                            vm.filterLocations(filter: .transport, isTrue: isTrain!)
                                        } label: {
                                            Label("Tram Only ", systemImage: (isTrain == false ) ? "checkmark.circle" : "circle")
                                        }
                                
                                      
                                    }
                                    .padding(.all , 6)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(4)
                                //My ki filter
                                Text("MyKi TopUp")
                                    .contextMenu {
                        
                                        Button {
                                            isMyKi = true
                                            showAll = false
                                            isExpress = nil
                                            isTrain = nil
                                           
                                            vm.filterLocations(filter: .topup, isTrue: isMyKi!)
                                        } label: {
                                            Label("Yes ", systemImage: (isMyKi == true ) ? "checkmark.circle" : "circle")
                                        }
                                        Button {
                                            isMyKi = false
                                            showAll = false
                                            isExpress = nil
                                            isTrain = nil
                                            vm.filterLocations(filter: .topup, isTrue: isMyKi!)
                                        } label: {
                                            Label("No ", systemImage: (isMyKi == false ) ? "checkmark.circle" : "circle")
                                        }
                                
                                      
                                    }
                                    .padding(.all , 6)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(4)
                                
                                
                                //Is exprees filter
                                
                                Text("Is Express")
                                    .contextMenu {
                 
                                
                                        Button {
                                            isExpress = true
                                            showAll = false
                                            isMyKi = nil
                                            isTrain = nil
                                            print("Change express")
                                            vm.filterLocations(filter: .express, isTrue: isExpress!)
                                            
                                        } label: {
                                            Label("Is Express", systemImage: (isExpress == true ) ? "checkmark.circle" : "circle")
                                        }
                                        Button {
                                            isExpress = false
                                            showAll = false
                                            isMyKi = nil
                                            isTrain = nil
                                            print("Change express")
                                            vm.filterLocations(filter: .express, isTrue: isExpress!)
                                            
                                        } label: {
                                            Label("Is Normal", systemImage: (isExpress == false ) ? "checkmark.circle" : "circle")
                                        }

                        
                                    }
                                    .padding(.all , 6)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(4)
                            }
                            .padding(.all , 6)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(4)
                            

             
                        }.padding()
         
            
                    }
                    Spacer()
                }
            }else {
                Text("No data for map to show ")
            }

 
        }
        .onChange(of: vm.filteredLocations, perform: { newValue in
            locationData = vm.filteredLocations
        })
        .onAppear {
            locationData = vm.filteredLocations

            
        }

        
    }
  
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
