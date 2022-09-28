//
//  SentimentDialView.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 7/21/22.
//

import SwiftUI

struct SentimentDialView: View {
    let ticker: String
    @State var averageScore: Double = 0.0
    
    var body: some View {
        
        
        ZStack {
            VStack {
                Spacer()
                DialView(maxProgress: averageScore/4)
                
                VStack(spacing: 0) {
                    Text("Social Media is ")
                        .font(.title)
                    + Text(averageScore/4 < 33.3 ? "bearish" : (averageScore/4 < 66.6 ? "neutral" : "bearish"))
                        .font(.title.bold())
                        .foregroundColor(averageScore/4 < 33.3 ? .red : (averageScore/4 < 66.6 ? .gray : .green))
                    Text(" on \(ticker)")
                        .font(.title)
                    + Text("(" + String(round((averageScore/4) * 10) / 10.0) + ")%")
                        .font(.title)
                        .foregroundColor(averageScore/4 < 33.3 ? .red : (averageScore/4 < 66.6 ? .gray : .green))
                }
                .padding(.top, 16)
                
                
            }
            .padding(.top, 48)
            
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.SentimentScore)) { score in
            guard let userInfo = score.userInfo, let sentimentScore = userInfo["score"] else {
                return
            }
            print(sentimentScore)
            DispatchQueue.main.async {
                averageScore += (sentimentScore as! Double)
            }
        
            
        }
        
        
    }
}

struct SentimentDialView_Previews: PreviewProvider {
    static var previews: some View {
        SentimentDialView(ticker: "TSLA")
    }
}

struct DialView: View {
    let colors = [Color(UIColor.red), Color(UIColor.green)]
    @State var progress: CGFloat = 0
    @State var maxProgress: CGFloat = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Meter(progress: self.$progress).onReceive(timer) { _ in
                increaseDial()
            }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.SentimentScore)) { score in
            guard let userInfo = score.userInfo, let sentimentScore = userInfo["score"] else {
                return
            }
            DispatchQueue.main.async {
                maxProgress += sentimentScore as! Double
            }
        
            
        }
        .onAppear {
            self.progress = 0
        }
    }
    
    func increaseDial() {
        withAnimation(Animation.default.speed(0.255)) {
            print("maxprogress: \(maxProgress)")
            if self.progress <= maxProgress/4 {
                self.progress += 5
            } else {
                // Stop the timer
                self.timer.upstream.connect().cancel()
            }
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
    let colorRange = [Color(UIColor.green), Color(UIColor.gray), Color(UIColor.red)]
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack {
                    
                    Circle()
                        .trim(from: 0, to: 1/6)
                        .stroke(colorRange[2].opacity(0.8), lineWidth: 55)
                        .frame(width: 250, height: 250)
                    Circle()
                        .trim(from: 1/6, to: 2/6)
                        .stroke(colorRange[1].opacity(0.8), lineWidth: 55)
                        .frame(width: 250, height: 250)
                    Circle()
                        .trim(from: 2/6, to: 3/6)
                        .stroke(colorRange[0].opacity(0.8), lineWidth: 55)
                        .frame(width: 250, height: 250)
                    
                }
            }.rotationEffect(.init(degrees: 180))
            
            ZStack(alignment: .bottom) {
                let color: Color = progress < 33 ? colorRange[2] : progress < 66 ? colorRange[1] : colorRange[0]
                
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
