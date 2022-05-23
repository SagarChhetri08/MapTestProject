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
    @State var isTrain:Bool = false
    @State var isTram:Bool = false
    @State var isNormal:Bool = false
    @State var isExpress:Bool = false
    @State var isMyKi:Bool = false
    @State var isNotMyKi:Bool = false

    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ZStack{
                    
                    if let data = locationData {
                       
                        Map(coordinateRegion: $vm.mapRegion, annotationItems: data.locations) { location in
                            MapAnnotation(coordinate:CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                                
                                let transportType = (location.typeID == 0) ? "Train" : "Tram"
                     
                                PlaceAnnotationView( title: location.name + " "+"( \(transportType) )", datetime: vm.convertStingDate(dateString: location.departureTime))
                            }
                        }
                        
                    }else {
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                ProgressView("Please wait...")
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                Spacer()
                                
                            }
    
                            Spacer()
                        }.padding()
                        
         
                    }

         
                }
                .onChange(of: vm.filteredLocations, perform: { newValue in
                    locationData = vm.filteredLocations
                })
                .onAppear {
                    locationData = vm.filteredLocations
                }

                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle("Map View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                  ToolbarItemGroup(placement: .navigationBarTrailing) {
                      
                      Menu {
                          Button {
                              showAll = true
                               isTrain = false
                               isTram = false
                               isNormal = false
                               isExpress = false
                               isMyKi = false
                              isNotMyKi = false
                              
                              if showAll{
                                  vm.showAllData()
                              }
                            
                          } label: {
                              Label("All ", systemImage: (showAll == true ) ? "checkmark.circle" : "circle")
                          }
                          Button {
                              isTrain.toggle()
                               showAll = false
                               isTram = false
                               isNormal = false
                               isExpress = false
                               isMyKi = false
                              isNotMyKi = false
                              if isTrain{
                                  vm.filterLocations(filter: .transport, isTrue: true)
                              }else{
                                  showAll = true
                                  vm.showAllData()
                              }
                          } label: {
                              Label("Trains Only", systemImage: (isTrain == true ) ? "checkmark.circle" : "circle")
                          }
                          Button {
                              isTram.toggle()
                               isTrain = false
                               showAll = false
                               isNormal = false
                               isExpress = false
                               isMyKi = false
                              isNotMyKi = false
                              if isTram{
                                  vm.filterLocations(filter: .transport, isTrue: false)
                              }else{
                                  showAll = true
                                  vm.showAllData()
                              }
                          } label: {
                              Label("Trams Only", systemImage: (isTram == true ) ? "checkmark.circle" : "circle")
                          }
                          Button {
                              isExpress.toggle()
                               isTrain = false
                               isTram = false
                               isNormal = false
                               showAll = false
                               isMyKi = false
                              isNotMyKi = false
                              if isExpress{
                                  vm.filterLocations(filter: .express, isTrue: true)
                              }else{
                                  showAll = true
                                  vm.showAllData()
                              }
                          } label: {
                              Label("Express", systemImage: (isExpress == true ) ? "checkmark.circle" : "circle")
                          }
                          Button {
                              isNormal.toggle()
                               isTrain = false
                               isTram = false
                               showAll = false
                               isExpress = false
                               isMyKi = false
                              isNotMyKi = false
                              if isNormal{
                                  vm.filterLocations(filter: .express, isTrue: false)
                              }else{
                                  showAll = true
                                  vm.showAllData()
                              }
                              
                          } label: {
                              Label("Normal", systemImage: (isNormal == true ) ? "checkmark.circle" : "circle")
                          }
                          Button {
                              isMyKi.toggle()
                               isTrain = false
                               isTram = false
                               isNormal = false
                               isExpress = false
                               showAll = false
                              isNotMyKi = false
                              if isMyKi{
                                  vm.filterLocations(filter: .topup, isTrue: true)
                              }else{
                                  showAll = true
                                  vm.showAllData()
                              }
                          } label: {
                              Label(" Has MykiTopUp ", systemImage: (isMyKi == true ) ? "checkmark.circle" : "circle")
                          }
                          Button {
                              isNotMyKi.toggle()
                               isTrain = false
                               isTram = false
                               isNormal = false
                               isExpress = false
                               isMyKi = false
                              showAll=false
                              if isNotMyKi{
                                  vm.filterLocations(filter: .topup, isTrue: false)
                              }else{
                                  showAll = true
                                  vm.showAllData()
                              }
                          } label: {
                              Label("Has Not Myki TopUp", systemImage: (isNotMyKi == true ) ? "checkmark.circle" : "circle")
                          }

                      } label: {
//                          Label("Menu", systemImage: "ellipsis.circle")
                          Image("sort").resizable().frame(width: 30, height: 30)
                          
                      }
                
          

                  }
              }
        }

       
        

    }
  
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
