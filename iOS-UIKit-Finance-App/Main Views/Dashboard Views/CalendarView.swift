//
//  CalendarView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                // Date
                VStack {
                    Text("Friday")
                    Text("29")
                }
                
                Spacer()
                // Divider
                HStack {
                    Divider()
                }.frame(height: 100)
                
                Spacer()
                Spacer()
                // Events
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.green)
                   
                    VStack {
                        Text("TSLA Earnings Call")
                        Text("2:30 PM - 3:00 PM")
                    }
                    
                }
                
                Spacer()
            }.overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(UIColor.green), lineWidth: 3)
            )
                .cornerRadius(15)
                .padding()
                .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
            
            
        }.padding(8)
        .frame(width: UIScreen.main.bounds.size.width, alignment: .center)
            .cornerRadius(16)
                
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
