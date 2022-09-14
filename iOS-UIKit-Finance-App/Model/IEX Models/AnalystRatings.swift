//
//  AnalystRatings.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 8/23/22.
//

import Foundation

// TODO: Add analyst data from Refintiv
// Current data is more of a price target (from doc.)
struct AnalystRatings: Codable, Identifiable {
    let id: String?
    let key: String?
    let subkey: String?
    let symbol: String?
    let analystCount: Int?
    let consensusDate: String?
    let marketConsensus: Double?
    let marketConsensusTargetPrice: Double?
    //let date: Int64
    //let updated: Int64
}



// Refintiv data
/**
 
 [
   {
     "ratingBuy": 12,
     "ratingOverweight": 21,
     "ratingHold": 7,
     "ratingUnderweight": 0,
     "ratingSell": 1,
     "ratingNone": null,
     "ratingScaleMark": 1.475609756097561,
     "consensusStartDate": 1625961600000,
     "corporateActionsAppliedDate": null,
     "consensusEndDate": 1625875200000,
     "ratingScaleMarkOneToFive": 1.95122
   }
 ]
 
 */
