//
//  WatchlistManager.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 9/25/22.
//

import UIKit
import CoreData

// This will be refactored when users can select multiple stocks to view at one time
public class WatchlistManager {
    
    static let shared = WatchlistManager()
    
    public var companyInfo: CompanyInfo?
    
    lazy var coreDataContext: NSManagedObjectContext = {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }() as! NSManagedObjectContext
    
    
    public var tickerSelected: String = "" {
        didSet {
            do {
                print("\(String(describing: self.tickerSelected)) is now selected")
                let newStock = Stock(context: self.coreDataContext)
                newStock.name = tickerSelected
                try self.coreDataContext.save()
            } catch {
                fatalError("Could not save to core data")
            }
         
        }
    }
    
    public var coreDataTicker: String {
        do {
            let tickers = try coreDataContext.fetch(Stock.fetchRequest())
            print("zzz:jj \(tickers[0].name!)")
            return tickers[0].name!
        } catch {
            fatalError("Could not retrieve stock")
        }
    }
    
    public func fetchStockData() {
        if tickerSelected != "" {
            Task(priority: .medium) {
                print("running \(tickerSelected)")
                let result = await IEXApiService().getCompanyInfo(stock: coreDataTicker.lowercased())
                switch result {
                case .success(let response):
                    print(response)
                    self.companyInfo = response
                    
                case .failure(let error):
                    self.companyInfo = nil
                }
            }
        }
    }
}
