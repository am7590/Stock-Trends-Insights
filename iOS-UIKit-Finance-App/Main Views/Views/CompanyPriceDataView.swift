//
//  CompanyPriceData.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CompanyPriceDataView: View {
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Text("This is CompanyTechnicalData")
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                Text("Item 4")
            }
            
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .cornerRadius(16)
            .padding(.horizontal)  
    }
}

struct CompanyPriceData_Previews: PreviewProvider {
    static var previews: some View {
        CompanyPriceDataView()
    }
}
