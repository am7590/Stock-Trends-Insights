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
        let hourDate = dateFormatter.string(from: date.localDate())
        return Int(hourDate.prefix(2)) ?? 0 > 12 ? "afternoon" : "morning"
    }
    
    var marketIsOpen: Bool {
        var statusString = false
        
        if let welcomeData = welcomeData {
            if welcomeData.status == "open" {
                statusString = true
            }
        }
        
        return statusString
    }
    
    var whenMarketOpensOrCloses: String {
        if marketIsOpen {
            return "and closes at \(welcomeData?.openClose ?? "")pm"
        } else {
            return "and opens \(welcomeData?.openDate.prefix(5) ?? "") at \(welcomeData?.openTime ?? "" )am"
        }
    }
    
//    var marketStatus: String {
//        if marketIsOpen {
//            return "today is"
//        } else {
////            let currentDate = date.localDate().description.prefix(10).replacingOccurrences(of: "-", with: "/")
////            let formattedCurrentDate = currentDate.suffix(5) + "/" + currentDate.prefix(4)
////            let marketOpenDate = welcomeData?.openDate ?? "01/01/2000"
//            return "on"
//        }
//    }
    
    var openCloseTime: String {
        if let welcomeData = welcomeData {
            let openTime = welcomeData.openTime.prefix(5)
            let closeTime = welcomeData.openClose.prefix(5)
            return marketIsOpen ? String(closeTime) : String(openTime)
        }
        return "Error"
    }
    
    var dayOfWeek: String {
        if let welcomeData = welcomeData {
            let dayOfWeek = getDayOfWeek(welcomeData.openDate)
            print(welcomeData.openDate)
            print(dayOfWeek)
            return dayFromInt(dayOfWeek: dayOfWeek!)
        } else {
            return ","
        }
    }
    
    func getDistanceInDays(firstDate: String, secondDate: String) -> String {
        print("Zzz \(secondDate) \(firstDate)")
        guard let firstDay = getDayOfWeek(firstDate), let secondDay = getDayOfWeek(secondDate) else {
            fatalError("days of the week are nil")
        }
        print("\(secondDay) - \(firstDay)")
        
        switch abs(secondDay - firstDay) {
        case 0:
            return "today"
        case 1:
            return "tomorrow"
        case 2:
            return "in two days"
        case 3:
            return "in three days"
        case 4:
            return "in four days"
        case 5:
            return "in five days"
        default:
            return ""
        }
    }

    func load() {
        Task(priority: .medium) {
            print("aaaa: \(date.localDate().advanced(by: 24))")
            let url = "https://finviz-news-sentiment-analysis-non-redis-api.apps.okd4.csh.rit.edu/welcome/?date=\(date.localDate().advanced(by: 1).description.prefix(10))"
            print("aaaaa: \(url)")
            let result = await sendRequest(url: url, responseModel: WelcomeDates.self)
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
    
    func getDayOfWeek(_ today: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func dayFromInt(dayOfWeek: Int) -> String {
        switch dayOfWeek {
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        case 1:
            return "Sunday"
        default:
            return ""
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

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

extension Date {
    func adding(_ component: Calendar.Component, _ value: Int) -> Date? {
        return  Calendar.current.date(byAdding: component, value: value, to: self)
    }
}

