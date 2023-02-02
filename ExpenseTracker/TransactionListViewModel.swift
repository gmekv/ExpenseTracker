//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Giorgi Meqvabishvili on 25.01.23.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction] >


final class TransactionListViewModel: ObservableObject {
    
    //MARK: New Expense Properties
//    @Published var addNewExpense: Bool = false
//    @Published var amount: String = ""
//    @Published var type: ExpenseType = .all
//    @Published var 
    
    
    
    @Published  var sortedTransactions: [Transaction] = []

    @Published var transactions: [Transaction] = [] {
        didSet {
            self.sortedTransactions = self.transactions.sorted {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let date0 = dateFormatter.date(from: $0.date) ?? Date()
                let date1 = dateFormatter.date(from: $1.date) ?? Date()
                return date0 > date1
            }
        }
    }

    
    private var cancellables = Set<AnyCancellable> ()
    
    init() {
        getTransactions()
        print(sortedTransactions)
    }
    
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                print(response)
                print(data)


                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print(data)
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                        return data
                }
        
            .decode(type: [Transaction].self, decoder: JSONDecoder())
           
            .receive(on: DispatchQueue.main)
        
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error Catching Transactions", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                    
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)

            }
            .store(in: &cancellables)
            }


  
    

    
//    func accumulateTransactions() -> TransactionPrefixSum {
//        
//        print("accumateTran")
//        
//        guard !transactions.isEmpty else { return [] }
//        
//        
//        let today = "01/28/2022".dateParse()
//        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
//        print("dateInterval", dateInterval)
//        var sum: Double = .zero
//        var cumulativeSum = TransactionPrefixSum()
//        
//        
//    }
    
    
    
    }
    
    

