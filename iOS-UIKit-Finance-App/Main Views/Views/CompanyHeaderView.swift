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
                .padding()
        }
        
        .onTapGesture {
            flipCard()
        }
    }
    
}

struct CompanyHeaderView: View {
    
    var body: some View {
        Section(content: { CompanyHeaderFlippingView().foregroundColor(Color.black) })
        
            .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .leading)
    }
}

struct CompanyHeaderFront: View {
    @StateObject var viewModel = CompanyHeaderViewModel()
    @Binding var degree: Double
    
    var body: some View {
        
        //if let companyName = viewModel.companyInfo?.companyName {
        Group {
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
        }
        
        .onAppear(perform: { viewModel.load() })
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
        //}
    }
}

struct CompanyHeaderDataView: View {
    let companyInfo: CompanyInfo
    let logo: Logo
    
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            
            VStack {
                HStack {
                    VStack {
                        if let logo = logo.url {
                            AsyncImage(url: logo) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: size.width/4, height: size.width/4)
                            .padding(.top, 24)
                        }
                        
                        Spacer()
                    }
                    
                    
                    VStack {
                        VStack {
                            HStack {
                                if let securityName = companyInfo.securityName{
                                    Text(securityName)
                                        .font(.largeTitle)
                                        .bold()
                                }
                                
                                Spacer()
                                Text("NASDAQ")  // TODO: Find data here
                                    .font(.subheadline)
                            }
                            .frame(minHeight: 0, maxHeight: .infinity)
                            .padding([.top, .bottom])

                            
                            if let tags = companyInfo.tags {
                                Group {
                                    FlexibleView(
                                        availableWidth: size.width-size.width/4-16, data: tags[0...2],
                                        spacing: 8,
                                        alignment: .leading
                                    ) { item in
                                        Text(verbatim: item)
                                            .padding(4)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.red.opacity(0.4))
                                            )
                                    }
                                }
                                .padding(.top, -24)
                                .padding(.leading, 4)
                                
                            }
                               
                            
                        }
                    }
                } .frame(minHeight: 0, maxHeight: .infinity)
            }
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

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State var elementsSize: [Data.Element: CGSize] = [:]
    
    var body : some View {
        GeometryReader{ proxy in
            VStack(alignment: alignment, spacing: spacing) {
                ForEach(computeRows(), id: \.self) { rowElements in
                    HStack(spacing: spacing) {
                        ForEach(rowElements, id: \.self) { element in
                            content(element)
                                .fixedSize()
                                .readSize { size in
                                    elementsSize[element] = size
                                }
                        }
                        
                        Spacer()
                    }
                }
            }.frame(width: proxy.size.width)
        }
    }
    
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }
        
        return rows
    }
    
}

