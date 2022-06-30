//
//  CompanyHeaderView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

struct CompanyHeaderView: View {
    var body: some View {
        ZStack {
            Color.green
            Text("This is CompanyHeaderView")
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .padding(.horizontal)
    }
}

struct CompanyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyHeaderView()
    }
}
