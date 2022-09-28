//
//  CompanyHeaderDataView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/14/22.
//

import SwiftUI

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
                                        spacing: 4,
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
                                .padding(.top, -20)
                                .padding(.leading, 4)
                                
                            }
                            
                            
                        }
                    }
                } .frame(minHeight: 0, maxHeight: 300)
            }
        }
    }
}
