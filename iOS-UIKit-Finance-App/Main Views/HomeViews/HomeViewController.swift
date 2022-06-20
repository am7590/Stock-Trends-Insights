//
//  HomeViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/22/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let cells = ["Analyst ratings", "Calendar", "Leave a review", "User feedback survey", "Terms of Service & Privacy Policy"]
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published private var listOfSecurities:[Stock]?
    var analystDataNotLoaded = true
    
    var tableView = UITableView()
    var headerView = HomeHeaderView(frame: .zero)
    // let service = APICall()
    private let service: IEXServicable
    
    init(service: IEXServicable) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        //let url = URL(string: "https://cloud.iexapis.com/stable/time-series/CORE_ESTIMATES/TSLA?token=pk_b8d39299974f41f99ef8f79101ab2617")!
        //service.fetch()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if analystDataNotLoaded {
            //fetchSecurities()
            loadAnalystData()
        }
    }
    
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        self.configureTableHeaderView()
    }

    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if indexPath.row >= 2 {
            
        } else if indexPath.row == 1 {
            cell =  UITableViewCell()  //AnalystRatingsView(coder: NSCoder) ??
        } else {
            //cell.backgroundColor = UIColor(red: 247.0/255, green: 247.0/255, blue: 247.0/255, alpha: 1.0)
            cell.layer.cornerRadius = 25
        }
            
        cell.textLabel?.text = cells[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
        
        
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= 2 {
            return 40
        } else {
            return 224
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 144
    }
    

    // MARK: Get stock data from CoreData
    func fetchSecurities() {
        do {
            self.listOfSecurities = try context.fetch(Stock.fetchRequest()) // Get all items
            
        } catch {
            
        }
    }
    
    private func loadAnalystData() {
        
        Task(priority: .background) {
            let result = await service.getLogo(stock: "TSLA")
            switch result {
            case .success(let response):
                print(response.url ?? "")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        Task(priority: .background) {
            let result = await service.getCompanyInfo(stock: "GME")
            switch result {
            case .success(let response):
                print(response)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
        
//        service.fetchAnalystRatings(ticker: "TSLA", completion: { result in
//            switch result {
//            case .success(let ratings):
//                self.analystDataNotLoaded = false
////                self.label.text = "\(ratings[0].symbol)  \(ratings[0].consensusDate)"
////                self.label2.text = "\(ratings[0].analystCount) analaysts feel \(ratings[0].marketConsensus)"
////                self.label3.text = "Price target: \(ratings[0].marketConsensusTargetPrice)"
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        })
        
//        service.fetchLogo(ticker: "TSLA", completion: { result in
//            switch result {
//            case .success(let logo):
//                print(logo)
//                // TODO: parse json
//            
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        })
        
        
//        service.fetchCompanyInfo(ticker: "TSLA", completion: { result in
//            switch result {
//            case .success(let companyInfo):
//                print(companyInfo)
//                // TODO: parse json
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        })
        
    }

    // (with header: Header)
    private func configureTableHeaderView() {
        let vm = ViewModel(welcomeLabel: "Good Afternoon Alek", statusMessage1: "The markets are currently closed.", statusMessage2: "", statusMessage3: "")
        headerView.configure(viewModel: vm)
    }
    
//    private func configureTableCells(with accounts: [Account]) {
//        accountCellViewModels = accounts.map {
//            AccountSummaryCell.ViewModel(accountType: $0.type,
//                                         accountName: $0.name,
//                                         balance: $0.amount)
//        }
//    }
    
}

