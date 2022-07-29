//
//  CompanyHeaderView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

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
            Color(UIColor.secondarySystemBackground)
            CompanyHeaderBack(degree: $frontDegree)
            CompanyHeaderFront(degree: $backDegree)
        }
        
        .onTapGesture {
            flipCard()
        }
    }
    
}

struct CompanyHeaderView: View {
    
    var body: some View {
        Section(content: { CompanyHeaderFlippingView().foregroundColor(Color.black) })
            
            .frame(width: UIScreen.main.bounds.size.width, height: 350, alignment: .leading)
    }
}

struct CompanyHeaderFront: View {
//    var title: String
//    var iconSystemName: String
//    var DataView: AnyView
//    var viewModel: AnyClass
    
    @StateObject var viewModel = CompanyHeaderViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        //if let companyName = viewModel.companyInfo?.companyName {
            FundamentalDataView(systemImage: "info", title: "Fundamentals", content: {
                switch viewModel.state {
                case .loaded:
                    if let companyInfo = viewModel.companyInfo, let logo = viewModel.logo {
                        CompanyHeaderDataView(companyInfo: companyInfo, logo: logo)
                    }
                    
                case .error(let error):
                    Text(error)
                case .empty(let empty):
                    Text(empty)
                default:
                    Text("Loading...")
                }
            })
        
            .onAppear(perform: { viewModel.load() })
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
        //}
    }
}

struct CompanyHeaderDataView: View {
    let companyInfo: CompanyInfo
    let logo: Logo
    
    var body: some View {
        
        HStack {
            if let logo = logo.url {
                AsyncImage(url: logo) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
            }
            
            if let exchange = companyInfo.exchange, let industry = companyInfo.industry {
                Text(String(describing: "Exchange: \(exchange), Industry: \(industry)"))
            }
        }
        
        if let securityName = companyInfo.securityName, let issueType = companyInfo.issueType {
            Text(String(describing: "securityName: \(securityName), issueType: \(issueType)"))
        }
        
        if let sector = companyInfo.sector, let employees = companyInfo.employees {
            Text(String(describing: "sector: \(sector), employees: \(employees)"))
        }
        
        if let tags = companyInfo.tags {
            ScrollView {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag).font(.caption)
                    }
                }
            }
            
        }
        
        if let address = companyInfo.address, let state = companyInfo.state, let city = companyInfo.city {
            Text(address + "\n" + city + ", " + state)
        }
    }
}


struct CompanyHeaderBack: View {
    @Binding var degree: Double
    @StateObject var viewModel = CompanyHeaderViewModel()
    
    var body: some View {
        
            Form {
                if let symbol = viewModel.companyInfo?.symbol {
                    Label("More about " + symbol, systemImage: "info.circle.fill")
                        .font(.title3)
                        .padding(.horizontal)
                }

                if let description = viewModel.companyInfo?.description {
                    Text(description)
                }

                if let website = viewModel.companyInfo?.website {
                    Button(action: {}, label:{ Link("Learn more", destination: URL(string: website)!)})
                }
                
            }.onAppear(perform: { viewModel.load() })

            .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
        }
}


struct CompanyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyHeaderView()
    }
}



