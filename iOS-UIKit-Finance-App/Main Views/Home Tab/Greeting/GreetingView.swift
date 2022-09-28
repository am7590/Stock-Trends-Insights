//
//  GreetingView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 6/29/22.
//

import SwiftUI

//enum MorningStatus {
//    case morning, afternoon
//
//    var getStatus: String {
//
//    }
//}

struct GreetingView: View {
    
    @StateObject var viewModel: GreetingViewModel
    
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loading:
                Text("Loading...")
            case .error(let error):
                Text("Error loading data: \(error)")
            default:
                VStack(alignment: .leading) {
                    Text("Good \(viewModel.morningStatus),")
                        .font(.largeTitle)
                    Group {
                        Text("The market is ") +
                        Text("\(viewModel.marketIsOpen ? "open." : "closed.")")
                            .foregroundColor(viewModel.marketIsOpen ? .green : .red)
                            .bold()
                    }.font(.title)
                    
                    HStack {
                        Spacer()
                        
                        // Date
                        VStack {
//                            Text(viewModel.marketStatus)
//                                .font(.subheadline)
                            Text(viewModel.dayOfWeek)
                            Text(viewModel.welcomeData?.openDate.prefix(5) ?? "")
                        }.foregroundColor(.black)
                            .font(.largeTitle.bold())
                            .scaleEffect(0.8)
                        
                        Spacer()
                        // Divider
                        HStack {
                            Divider()
                                .background(.black)
                        }.frame(height: 100)
                        
                        Spacer()
                        
                        // Events
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.red)
                            
                            VStack(alignment: .leading) {
                                Text("Market \(viewModel.marketIsOpen ? "closes" : "opens")")
                                    .font(.title3)
                                Group {
                                    Text(viewModel.openCloseTime)
                                    + Text(viewModel.marketIsOpen ? "pm" : "am")
                                }
                                .font(.subheadline.bold())
                            }
                        }
                        
                        Spacer()
                    }
                    
                }
                .padding()
                .onAppear {
                    let date = Date()
                    print(date)
                    
                }
            }
        }.onAppear {
            viewModel.load()
        }
        .frame(height: 200)
        
        
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView(viewModel: GreetingViewModel())
    }
}
