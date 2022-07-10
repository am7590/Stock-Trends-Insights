//
//  CEODataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

let width: CGFloat = UIScreen.main.bounds.size.width
let height: CGFloat = 200

struct CEODataView: View {
    
    var body: some View {
        ZStack {
            FlippingView()
        }.frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center)
            .padding(.horizontal)
            .fixedSize(horizontal: false, vertical: true)
        
    }
    
}


struct FlippingView: View {
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
            CEOCompensationBack(degree: $frontDegree)
            CEOCompensationFront(degree: $backDegree)
        }.onTapGesture {
            flipCard()
        }
    }
    
}

// TODO: Only flip sheet part of view (if possible)
struct CEOCompensationFront: View {
    
    @StateObject var viewModel = CEODataViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            HStack {
                Text("Ceo Compensation")
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
            }.listRowBackground(Color(UIColor.green))
        
//        switch viewModel.state {
//        case .loaded:
                VStack {
                    Text(String(describing: "Name: \(String(describing: viewModel.ceoCompensation?.name))"))
                    Text(String(describing: "salary"))
                    Text(String(describing: "bonus"))
                    Text(String(describing: "stockAwards"))
                    Text(String(describing: "optionAwards"))
                    Text(String(describing: "total"))
                }
                .listRowBackground(Color(UIColor(red: 0.4, green: 0.8, blue: 0.5, alpha: 1)))
                //.frame(width: width-16, height: height)
                
//        case .loading:
//            Text("loading").onAppear { viewModel.load() }
//        case .empty(_):
//            Text("empty")
//        case .error(_):
//            Text("error")
//        }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}


struct CEOCompensationBack: View {
    
    @Binding var degree: Double
    
    var body: some View {
        
        
        Form {
            Label("What does this matter?", systemImage: "info.circle.fill")
                .font(.title2)
                .padding(.horizontal)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            Button(action: {}, label:{ Link("Learn more", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)})
        }
        
        
        
        .frame(width: width-16, height: height)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct CEODataView_Previews: PreviewProvider {
    static var previews: some View {
        CEODataView()
    }
}
