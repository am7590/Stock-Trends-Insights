//
//  NSNotification+SentimentScore.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/18/22.
//

import Foundation

extension NSNotification {
    static let SentimentScore = Notification.Name.init("SentimentScore")
    static let NextPage = Notification.Name.init("NextPage")
    static let FinishOnboarding = Notification.Name.init("FinishOnboarding")
}
