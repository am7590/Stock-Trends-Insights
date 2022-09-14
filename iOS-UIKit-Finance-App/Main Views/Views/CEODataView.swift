//
//  CEODataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/30/22.
//

import SwiftUI
import MapKit

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
        }
        .onTapGesture {
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
        
        Group {
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
        }
        .onAppear(perform: { viewModel.load() })
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
        
    }
}

struct CEOCompensationView: View {
    let viewModel: CEODataViewModel
    
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
                .fill((Color.white).shadow(.drop(radius: 2)))
        }.padding(.horizontal)
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



struct SalaryInfoView: View {
    let title: String
    let info: String
    var divider: Bool = true
    
    var body: some View {
        VStack {
            Text("\(title): \n")
            + Text("$\(info)")
                .font(.title3.bold())
        }
        
        if divider {
            Divider()
                .padding(.vertical)
        }
        
    }
}

struct CEOHeaderView: View {
    
    let geocoder = CLGeocoder()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 30.222296,
            longitude: -97.617134),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01)
    )
    
    var body: some View {
        
        VStack {
            ZStack {
                
                Map(coordinateRegion: $region)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill((Color.white).shadow(.drop(radius: 2)))
                    }.frame(height: 150)
                
                HStack {
                    
                    Image("elon")
                        .resizable()
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                        .shadow(radius: 15)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    
                    Spacer()
                }.padding(.leading, 10)
                    .padding(.bottom, 15)
            }
            
        }.padding()
        
    }
}
