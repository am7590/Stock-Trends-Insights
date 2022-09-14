//
//  CompanyHeaderView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI


struct CompanyHeaderView: View {
    
    var body: some View {
        Section(content: { CompanyHeaderFlippingView().foregroundColor(Color.black) })
        
            .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .leading)
    }
}


struct CompanyHeaderFlippingView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let durationAndDelay: CGFloat = 0.2
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Color(UIColor.secondarySystemBackground)
            CompanyHeaderBack(degree: $frontDegree)
            CompanyHeaderFront(degree: $backDegree)
                .padding()
        }
        
        .onTapGesture {
            flipCard()
        }
    }
}


struct CompanyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyHeaderView()
    }
}

