//
//  RequestWatchlistViewController.swift
//  iOS-UIKit-Finance-App
//
//  Created by Alek Michelson on 5/21/22.
//

import UIKit
import Combine
import CoreData

class RequestWatchlistViewController: UIViewController {
    
    // Control which tableview is shown
    private enum Mode {
        case selected
        case search
    }
    
    lazy var coreDataContext: NSManagedObjectContext = {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }() as! NSManagedObjectContext
    
    // Stock search
    @Published private var searchQueryTextOccupied = false
    @Published private var mode: Mode = .selected
    @Published private var searchQuery = String()
    private var searchResults: SearchResults?
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    var loading = true
    var notSearchingQuery = false
    var canceledSearchController = false
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    
    let label = UILabel()
    let tableView = UITableView()
    let stackView = UIStackView()
    let doneButton = UIButton(type: .system)
   
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search to add another stock"
        sc.searchBar.autocapitalizationType = .allCharacters
        //sc.searchBar.scopeButtonTitles = ["Securities"]
//        sc.searchBar.barTintColor = .systemGreen
        return sc
    }()
    
    private let titleText: String
    
    // initializer w/ paramaters
    init(titleText: String) {
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        observeForm()
        fetchSecurities()
        style()
        layout()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    // MARK: CoreData
    
    // Second table view
    @Published private var orignalSearchQuery: [Stock]?
    
    @Published private var listOfSecurities:[Stock]?
    
    
    func fetchSecurities() {
        do {
            self.listOfSecurities = try coreDataContext.fetch(Stock.fetchRequest())  // Get all items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // TODO: Error handling
        }
    }
    
    private func observeForm() {
            
            // Call the API every 750 milliseconds
            $searchQuery
                .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
                .sink { [unowned self] (searchQuery) in
                    
                    // Stops function from searching empty query (bug fix)
                    guard !searchQuery.isEmpty else {
                        notSearchingQuery = true
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        return
                        
                    }
                    searchQueryTextOccupied = false
                    
                    // TODO: Loading animation
                    // showLoadingAnimation()
                    
                    self.apiService.fetchSymbolePublisher(ticker: searchQuery).sink { (completion) in
                        // hideLoadingAnimation()
     
                        switch completion {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .finished: break
                        }
                        
                    } receiveValue: { (searchResults) in
                        //print(searchResults)
                        self.searchResults = searchResults
     
                        // Reload tableview data
                        self.tableView.reloadData()
                        self.tableView.isScrollEnabled = true  // Enable scrolling w/ results
                        
                    }.store(in: &self.subscribers)
                }.store(in: &subscribers)
            
        }
}

extension RequestWatchlistViewController {
    private func style() {
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = titleText
        
        // tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 35
        
        // doneButton
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .systemGreen
        doneButton.layer.cornerRadius = 5
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0)
        doneButton.setTitle("Done", for: .normal)
        doneButton.tintColor = .secondarySystemBackground
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .primaryActionTriggered)
        doneButton.isUserInteractionEnabled = true

    }
    
    private func layout() {
        stackView.addArrangedSubview(label)
        
        let searchBarPlaceholderView = UIView()
        searchBarPlaceholderView.addSubview(searchController.searchBar)
        searchBarPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        searchBarPlaceholderView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        stackView.addArrangedSubview(searchBarPlaceholderView)

        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(doneButton)
        
        
        view.addSubview(stackView)
                
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])

//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
//            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
    @objc func doneButtonAction(sender: UIButton!) {
        delegate?.didFinishOnboarding()
        print("pressed")
    }
    
}

extension RequestWatchlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults?.items.count ?? 0
            
        }
        //return orignalSearchQuery.count
        return self.listOfSecurities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .systemGreen
        if let searchResults = self.searchResults {
            if canceledSearchController {
                
                cell.textLabel?.text = listOfSecurities?[indexPath.row].name
            }
            if searchController.isActive {
                if canceledSearchController {
                    print("two")
                    cell.textLabel?.text = listOfSecurities?[indexPath.row].name
                    canceledSearchController = false
                    
                } else {
                    let searchResult = searchResults.items[indexPath.row]
                    if searchQueryTextOccupied { return cell}
                    
                    if notSearchingQuery {
                        print("\(searchResult.symbol) \(searchResult.name)")
                        cell.textLabel?.text = searchResult.symbol
                        //cell.detailTextLabel?.text = searchResult.name   //
                    } else {
                        cell.textLabel?.text = "searchResult.symbol"
                        cell.detailTextLabel?.text = "searchResult.name"
                    }
                }
                
            }
        
        } else {
            fetchSecurities()
            print(listOfSecurities)
            let security = listOfSecurities?[indexPath.row]
            cell.textLabel?.text = security?.name
            cell.detailTextLabel?.text = ""
            
        }
        
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let searchResults = self.searchResults {
            let searchResult = searchResults.items[indexPath.item]
            let symbol = searchResult.symbol
            
            // MARK: didSelectRowat
            
            //print(orignalSearchQuery)
            handleSelection(for: symbol, searchResult: searchResult)
            
            // Save to core data
            do {
                let newStock = Stock(context: self.coreDataContext)
                newStock.name = symbol.uppercased()
                
                listOfSecurities?.append(newStock)
                print("listOfSecurities: \(listOfSecurities)")
                //orignalSearchQuery?.append(newStock)
                try self.coreDataContext.save()
            } catch {
                // Error
            }

            // Re-fetch data
            //self.fetchSecurities()
            self.tableView.reloadData()
            
        }
        
        // Prevent cells from being selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Called when the user types on the table view cell
    private func handleSelection(for symbol: String, searchResult: SearchResult) {
        
        if mode == .search {
            searchController.isActive = false
            self.canceledSearchController = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // TODO: Loading animation
        // showLoadingAnimation()
    }
}

extension RequestWatchlistViewController: UISearchResultsUpdating, UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        searchQueryTextOccupied = searchController.searchBar.text == ""
        // let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonImage]
        guard let searchQuery = searchController.searchBar.text,
              !searchQuery.isEmpty else { return }
            
        //filterTableView(searchText: searchController.searchBar.text ?? "")  // and scopebutton when enabled
        self.searchQuery = searchQuery
        tableView.reloadData()
    }
}
