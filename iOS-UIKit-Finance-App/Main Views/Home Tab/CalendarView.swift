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
                    Text("Market Opens")
                    Text("Friday")
                    Text("29")
                }.foregroundColor(.black)
                    .font(.largeTitle.bold())
                    .scaleEffect(0.8)
                
                Spacer()
                // Divider
                HStack {
                    Divider()
                        .background(.black)
                }.frame(height: 100)
                
                Spacer()
                Spacer()
                
                // Events
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.red)
                    
                    VStack {
                        Text("TSLA Earnings Call")
                        Text("2:30 PM - 3:00 PM")
                    }
                    
                }
                
                Spacer()
            }.foregroundColor(.black)
                .padding(15)
                .background(
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                )
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
