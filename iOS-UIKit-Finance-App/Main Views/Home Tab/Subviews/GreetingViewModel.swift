//
//  GreetingViewModel.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/24/22.
//

import Foundation

@MainActor class GreetingViewModel: StockAppViewModel, HTTPClient {
    @Published var welcomeData: WelcomeDates?
    @Published var state: State = .loading
    var parser = APIParser()
    let date = Date()
    
    var morningStatus: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hourDate = dateFormatter.string(from: date)
        return Int(hourDate.prefix(2)) ?? 0 > 12 ? "afternoon" : "morning"
    }
    
    var marketStatus: String {
        var statusString: String = "closed"
        
        if let welcomeData = welcomeData {
            if welcomeData.status == "open" {
                statusString = "open"
            }
        }
        
        return statusString
    }
    

    func load() {
        Task(priority: .medium) {
            let result = await sendRequest(url: "http://127.0.0.1:4200/welcome/?date=\(date.description.prefix(10))", responseModel: WelcomeDates.self)
            switch result {
            case .success(let success):
                self.welcomeData = success
                print(success)
                self.state = .loaded
            case .failure(let failure):
                self.state = .error(failure.customMessage)
                print(failure)
            }
        }
    }
}
        
struct WelcomeDates: Codable {
    let status: String
    let openDate: String
    let openTime: String
    let openClose: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case openDate = "open-date"
        case openTime = "open-time"
        case openClose = "open-close"
    }
}
