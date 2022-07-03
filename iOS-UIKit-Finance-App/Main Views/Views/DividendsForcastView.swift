//
//  DividendsForcastView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

struct DividendsForcastView: View {
    @StateObject var viewModel = DividendsForcastViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loaded:
                
                Color.yellow
                
                VStack {
                    
                    ForEach(viewModel.dividendsForcast!) { dividends in
                        Text(String(describing: dividends.declaredDate))
                        Text(String(describing: dividends.disbursementAmount))
                        Text(String(describing: dividends.disbursementType))
                        Text(String(describing: dividends.status))
                        
                     
                    }
                }
                
            case .error(let error):
                Text(error)
            case .loading:
                Text("loading...")
                    .onAppear { viewModel.load() }
            default:
                Text("Default")
                
            }
            
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .padding(.horizontal)
        
        
    }
}

struct DividendsForcastView_Previews: PreviewProvider {
    static var previews: some View {
        DividendsForcastView()
    }
}
