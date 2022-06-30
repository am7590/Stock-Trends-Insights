//
//  CompanyTechnicalData.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CompanyTechnicalData: View {
    var body: some View {
        ZStack {
            Color.blue
            Text("This is CompanyTechnicalData")
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .padding(.horizontal)
    }
}

struct CompanyTechnicalData_Previews: PreviewProvider {
    static var previews: some View {
        CompanyTechnicalData()
    }
}
