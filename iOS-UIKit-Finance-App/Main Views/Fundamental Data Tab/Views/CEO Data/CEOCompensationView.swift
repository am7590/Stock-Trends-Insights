//
//  CEOCompensationView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

struct CEOCompensationView: View {
    let viewModel: CEODataViewModel
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(spacing: 0) {
            CEOHeaderView()
            
            Group {
                Text("Tesla CEO")
                    .font(.title)
                
                + Text(" Elon Musk")
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
                
                + Text(" earned")
                    .font(.title)
                
                + Text(" $15,682,219")
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
                
                + Text(" last year:")
                    .font(.title)
                
            }.padding(.horizontal, 16)
            
            HStack {
                SalaryInfoView(title: "Salary", info: "82,219")
                SalaryInfoView(title: "Stocks & Options", info: "15,500,000")
                SalaryInfoView(title: "Other", info: "100,000", divider: false)
            }
            .frame(height: 80)
            //
            //                Text("Stock & Options: ")
            //                + Text("$15,500,000")
            //
        }
        .padding(-15)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
        }.padding(.horizontal)
    }
}

//struct CEOCompensationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CEOCompensationView()
//    }
//}
