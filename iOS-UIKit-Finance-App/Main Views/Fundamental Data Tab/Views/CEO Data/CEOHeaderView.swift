//
//  CEOHeaderView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI
import MapKit

struct CEOHeaderView: View {
    
    let geocoder = CLGeocoder()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 30.222296,
            longitude: -97.617134),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01)
    )
    
    var body: some View {
        
        VStack {
            ZStack {
                
                Map(coordinateRegion: $region)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill((Color.white).shadow(.drop(radius: 2)))
                    }.frame(height: 150)
                
                HStack {
                    
                    Image("elon")
                        .resizable()
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                        .shadow(radius: 15)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    
                    Spacer()
                }.padding(.leading, 10)
                    .padding(.bottom, 15)
            }
            
        }.padding()
        
    }
}


struct CEOHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CEOHeaderView()
    }
}
