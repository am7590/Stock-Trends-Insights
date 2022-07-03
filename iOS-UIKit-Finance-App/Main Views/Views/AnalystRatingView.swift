//
//  AnalystRatingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

struct AnalystRatingView: View {
    @StateObject var viewModel = AnalystRatingViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loaded:
                
                Color.purple
                
                VStack {
                    
                    ForEach(viewModel.analystRatings!) { ratings in
                        Text(String(describing: ratings.key))
                        Text(String(describing: ratings.consensusDate))
                        Text(String(describing: ratings.marketConsensus))
                        Text(String(describing: ratings.marketConsensusTargetPrice))
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

struct AnalystRatingView_Previews: PreviewProvider {
    static var previews: some View {
        AnalystRatingView()
    }
}

