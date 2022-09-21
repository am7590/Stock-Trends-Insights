//
//  NewsCellSubView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/20/22.
//

import SwiftUI

struct NewsCellSubView: View {
    @StateObject var viewModel: NewsViewModel
    
    var body: some View {
            VStack {
                Text(viewModel.news?.headline ?? "loading")
            }
        .background(.red)
        .frame(width: UIScreen.main.bounds.size.width, height: 112)
    }
}

//struct NewsCellSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsCellSubView()
//    }
//}
