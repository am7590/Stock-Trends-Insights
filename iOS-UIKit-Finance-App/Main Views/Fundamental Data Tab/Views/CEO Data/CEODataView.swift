//
//  CEODataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

let width: CGFloat = UIScreen.main.bounds.size.width

struct CEODataView: View {
    var body: some View {
        Section(content: { CEOFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 225, alignment: .leading)  // TODO: Refactor UIScreen.main.bounds.size.width
    }
}

struct CEODataView_Previews: PreviewProvider {
    static var previews: some View {
        CEODataView()
    }
}
