//
//  CEODataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI

let width: CGFloat = UIScreen.main.bounds.size.width

struct CEOFlippingView: View {
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
            Color(UIColor.secondarySystemBackground)
            CEOCompensationBack(degree: $frontDegree)
            CEOCompensationFront(degree: $backDegree)
        }.onTapGesture {
            flipCard()
        }
    }
    
}

struct CEODataView: View {
    
    var body: some View {
        Section(content: { CEOFlippingView().foregroundColor(Color.black) })
            .frame(width: UIScreen.main.bounds.size.width, height: 225, alignment: .leading)
    }
}

struct CEOCompensationFront: View {
//    var title: String
//    var iconSystemName: String
//    var DataView: AnyView
//    var viewModel: AnyClass
    
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
            VStack(alignment: .leading) {
                
                switch viewModel.state {
                case .loaded:
                    CEOCompensationView(viewModel: viewModel)
                case .error(let error):
                    Text(error)
                case .empty(let empty):
                    Text(empty)
                default:
                    Text("Loading...")
                }
                
            }.onAppear(perform: { viewModel.load() })
            .listRowBackground(Color(UIColor(red: 0.4, green: 0.8, blue: 0.5, alpha: 1)))
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct CEOCompensationView: View {
    let viewModel: CEODataViewModel
    
    var body: some View {
        Text(String(describing: "Name: \(viewModel.ceoCompensation?.name ?? "")"))
        
        if let compensation = viewModel.ceoCompensation?.salary {
            Text(String(describing: "Salary: \(compensation)"))
        }
        
        if let bonus = viewModel.ceoCompensation?.bonus {
            Text(String(describing: "Bonus: \(bonus)"))
        }
        
        if let stockAwards = viewModel.ceoCompensation?.stockAwards {
            Text(String(describing: "Stock Awards: \(stockAwards)"))
        }

        if let optionAwards = viewModel.ceoCompensation?.optionAwards {
            Text(String(describing: "Option Awards: \(optionAwards)"))
        }

        if let total = viewModel.ceoCompensation?.total {
            Text(String(describing: "Total Compensation: \(total)"))
        }
    }
}


struct CEOCompensationBack: View {
    @Binding var degree: Double
    
    var body: some View {
        
        Form {
            Label("Why are CEO's paid with stocks and options?", systemImage: "info.circle.fill")
                .font(.title3)
                .padding(.horizontal)
            Text("CEO's are more incentivized to act on behalf of their shareholders if you pay them a share-based compensation.")
            Button(action: {}, label:{ Link("Learn more", destination: URL(string: "https://www.investopedia.com/articles/stocks/07/executive_compensation.asp#:~:text=Executive%20compensation%20is%20a%20very,and%20boost%20the%20share%20price.")!)})
        }

        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}

struct CEODataView_Previews: PreviewProvider {
    static var previews: some View {
        CEODataView()
    }
}
