//
//  CalendarView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            Color.orange
            Text("This is CalendarView")
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .cornerRadius(16)
                
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
