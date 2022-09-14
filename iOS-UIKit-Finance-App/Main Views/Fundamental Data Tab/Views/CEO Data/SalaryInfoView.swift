//
//  SalaryInfoView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct SalaryInfoView: View {
    let title: String
    let info: String
    var divider: Bool = true
    
    var body: some View {
        VStack {
            Text("\(title): \n")
            + Text("$\(info)")
                .font(.title3.bold())
        }
        
        if divider {
            Divider()
                .padding(.vertical)
        }
        
    }
}

struct SalaryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryInfoView(title: "title", info: "info")
    }
}
