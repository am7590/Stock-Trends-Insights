//
//  DashboardViewHolder.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/24/22.
//

import SwiftUI

import SwiftUI

struct DashboardViewHolder: View {
    var body: some View {
        List {
            ForEach(0..<5) { i in
                Section {
                    Text("A new row \(i)")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct DashboardViewHolder_Previews: PreviewProvider {
    static var previews: some View {
        DashboardViewHolder()
    }
}
