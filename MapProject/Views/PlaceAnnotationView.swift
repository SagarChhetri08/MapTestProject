//
//  PlaceAnnotationView.swift
//  MapProject
//
//  Created by Sarad Chhetri on 22/5/2022.
//

import SwiftUI

struct PlaceAnnotationView: View {
    @State private var showTitle = true
    
    let title: String
    let datetime: String
    
    var body: some View {
      VStack(spacing: 0) {
          VStack{
              Text(title)
                .font(.callout)
         
                Text(datetime)
                  .font(.callout)

          }
          .padding(5)
          .background((Color.blue.opacity(0.8)))
            .foregroundColor(Color.white)
              .cornerRadius(10)
              .opacity(showTitle ? 0 : 1)

        
        Image(systemName: "mappin.and.ellipse")
              .font(.largeTitle)
          .foregroundColor(.blue)
        
      }
      .onTapGesture {
        withAnimation(.easeInOut) {
          showTitle.toggle()
        }
      }
    }
}

struct PlaceAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceAnnotationView(title: "Here", datetime: "")
    }
}
