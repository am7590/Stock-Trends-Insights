//
//  SentimentDial.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/21/22.
//

import SwiftUI

struct SentimentDial: View {
    var body: some View {
        ZStack {
            Home()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SentimentDial()
    }
}

struct Home: View {
    let colors = [Color(UIColor.red), Color(UIColor.green)]
    @State var progress: CGFloat = 0
    
    var body: some View {
        VStack {
            
            
            Meter(progress: self.$progress)
            
//            HStack(spacing: 25) {
//                Button(action: {
//                    increaseDial()
//                }) {
//                    Text("Update")
//                        .padding(.vertical)
//                        .frame(width: (UIScreen.main.bounds.width-50)/2)
//                }.background(Capsule().stroke(LinearGradient(gradient: .init(colors: self.colors), startPoint: .leading, endPoint: .trailing), lineWidth: 2))
//
//                Button(action: {
//                    resetDial()
//                }) {
//                    Text("Reset")
//                        .padding(.vertical)
//                        .frame(width: (UIScreen.main.bounds.width-50)/2)
//                }.background(Capsule().stroke(LinearGradient(gradient: .init(colors: self.colors), startPoint: .leading, endPoint: .trailing), lineWidth: 2))
//            }.padding(.top, 15)
            
        }
    }
    
    func increaseDial() {
        withAnimation(Animation.default.speed(0.55)) {
            self.progress += (self.progress != 100 ? 10 : 0)
        }
    }
    
    func resetDial() {
        withAnimation(Animation.default.speed(0.55)) {
            self.progress = 0
        }
    }
}


struct Meter: View {
    let colors = [Color(UIColor.red), Color(UIColor.green)]
    let colorRange = [Color(UIColor.green), Color(UIColor.yellow), Color(UIColor.red)]
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack {
                    
                    Circle()
                        .trim(from: 0, to: 1/6)
                        .stroke(colorRange[0].opacity(0.8), lineWidth: 55)
                        .frame(width: 250, height: 250)
                    Circle()
                        .trim(from: 1/6, to: 2/6)
                        .stroke(colorRange[1].opacity(0.8), lineWidth: 55)
                        .frame(width: 250, height: 250)
                    Circle()
                        .trim(from: 2/6, to: 3/6)
                        .stroke(colorRange[2].opacity(0.8), lineWidth: 55)
                        .frame(width: 250, height: 250)
                    
                }
            }.rotationEffect(.init(degrees: 180))
            
            ZStack(alignment: .bottom) {
                let color: Color = progress < 33 ? colorRange[0] : progress < 66 ? colorRange[1] : colorRange[2]
                
                ZStack {
                    Color.black
                        .frame(width: 8, height: 93)
                    color
                        .frame(width: 5, height: 90)
                }
                
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 20, height: 20)
                    
                    Circle()
                        .fill(color)
                        .frame(width: 15, height: 15)
                }
                
            }
            .offset(y: -35)
            .rotationEffect(.init(degrees: -90))
            .rotationEffect(.init(degrees: self.setArrow()))
        }
        .padding(.bottom, -140)
    }
    
    func setProgress() -> CGFloat {
        let temp = self.progress/2
        print(Double(temp*0.01))
        return Double(temp*0.01)
    }
    
    func setArrow() -> Double {
        let temp = self.progress/100
        return Double(temp*180)
    }
}
